class MatchesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_match, only: %i[ edit update show ]
    before_action :my_formhelpers, only: %i[ new edit create update ]
    authorize_resource

    def index
        @pagy, @matches = pagy(Match.includes(:tournament, :season, :stadium, :home_team, :visitor_team).order(start_at: :desc), limit: 15)
    rescue Pagy::OverflowError
        redirect_to matches_url(page: 1)
    end

    def new
        @match = Match.new
    end

    def create
        @match = Match.new(match_params)
        if @match.save
            redirect_to match_url(@match), notice: t('notice.create.match')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @match.update(match_params)
            redirect_to match_url(@match), notice: t('notice.update.match')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def show
    end

    private

    def set_match
        @match = Match.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to matches_url
    end

    def match_params
        params.require(:match).permit(:season_id, :tournament_id, :stage, :stadium_id, :start_at, :home_team_id, :home_goal, :visitor_team_id, :visitor_goal)
    end

    def my_formhelpers
        @teams = Team.formhelper
        @tournaments = Tournament.formhelper
        @stadia = Stadium.formhelper
        @seasons = Season.formhelper
    end
end
