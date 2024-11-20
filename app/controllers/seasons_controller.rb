# frozen_string_literal: true

class SeasonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_season, only: %i[edit update]
  authorize_resource

  def index
    @pagy, @seasons = pagy(Season.order(start_date: :desc, name: :asc), limit: 15)
  rescue Pagy::OverflowError
    redirect_to seasons_url(page: 1)
  end

  def new
    @season = Season.new
  end

  def edit; end

  def create
    last_season = Season.where(end_date: nil).last
    @season = Season.new(season_params)
    if last_season.present? && @season.end_date.nil?
      flash.now[:alert] = t('alert.create.season')
      render :new, status: :unprocessable_entity
    elsif @season.save
      redirect_to seasons_url, notice: t('notice.create.season')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    last_season = Season.where(end_date: nil).last
    season_start_date = @season.start_date
    season_end_date = @season.end_date
    if @season.update(season_params)
      if last_season.present? && @season.id != last_season.id && @season.end_date.nil?
        @season.update(start_date: season_start_date, end_date: season_end_date)
        flash.now[:alert] = t('alert.update.season')
        render :edit, status: :unprocessable_entity
      else
        redirect_to seasons_url, notice: t('notice.update.season')
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_season
    @season = Season.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to seasons_url
  end

  def season_params
    params.require(:season).permit(:name, :start_date, :end_date)
  end
end
