# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :authenticate_user!, except: %i[calendar gallery gallery_show]
  before_action :set_match, only: %i[edit update show attached_photos]
  before_action :my_formhelpers, only: %i[new edit create update]
  authorize_resource

  def index
    @pagy, @matches = pagy(Match.includes(:home_team, :visitor_team).order(start_at: :desc), limit: 15)
  rescue Pagy::OverflowError
    redirect_to matches_url(page: 1)
  end

  def show
    @fan_matches = FanMatch.where(match_id: @match.id)
    @fans = Fan.joins(:fan_matches).where(fan_matches: { match_id: @match.id }).order(:nickname)
    @match_videos = MatchVideo.where(match_id: @match.id)
    @videos = Video.joins(:match_video).where(match_video: { match_id: @match.id }).order(name: :desc)
  end

  def new
    @match = Match.new
  end

  def edit; end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to match_url(@match), notice: t('notice.create.match')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @match.update(match_params)
      redirect_to match_url(@match), notice: t('notice.update.match')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def calendar
    if Season.count != 0
      @seasons = Season.formhelper
      if params[:season_id].present?
        @active_season = Season.find(params[:season_id])
        @pagy, @matches = pagy(Match.season_matches(params[:season_id]), limit: 15)
      else
        @active_season = Season.where('end_date > ?',
                                      Time.zone.today).or(Season.where(end_date: nil)).order(:end_date).last
        if @active_season.present?
          @pagy, @matches = pagy(Match.season_matches(@active_season.id), limit: 15)
        else
          last_season_end_date = Season.maximum(:end_date)
          @last_season =  Season.where(end_date: last_season_end_date).last
          @pagy, @matches = pagy(Match.season_matches(@last_season.id), limit: 15)
        end
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to calendar_path
  rescue Pagy::OverflowError
    redirect_to calendar_path(page: 1)
  end

  def attached_photos; end

  def deleted_attached_photos
    @photos = ActiveStorage::Attachment.find(params[:id])
    @photos.purge
    redirect_back fallback_location: matches_path, notice: t('notice.destroy.photos')
  end

  def gallery
    @pagy, @seasons = pagy(Season.order(start_date: :desc, name: :asc), limit: 15)
  rescue Pagy::OverflowError
    redirect_to gallery_url(page: 1)
  end

  def gallery_show
    @season = Season.find(params[:season_id])
    @matches = Match.season_matches(params[:season_id]).with_attached_photos
  rescue ActiveRecord::RecordNotFound
    redirect_to gallery_url
  end

  private

  def set_match
    @match = Match.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to matches_url
  end

  def match_params
    params.require(:match).permit(:season_id, :tournament_id, :stage, :stadium_id, :start_at, :match_type,
                                  :home_team_id, :home_goal, :visitor_team_id, :visitor_goal, photos: [])
  end

  def my_formhelpers
    @teams = Team.formhelper
    @tournaments = Tournament.formhelper
    @stadia = Stadium.formhelper
    @seasons = Season.formhelper
  end
end
