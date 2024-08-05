class TeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_team, only: %i[ edit update ]
    authorize_resource

    def index
        @pagy, @teams = pagy(Team.order(:name, :location), limit: 15)
    rescue Pagy::OverflowError
        redirect_to teams_url(page: 1)
    end

    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        if @team.save
            redirect_to teams_url, notice: t('notice.create.team')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @team.update(team_params)
            redirect_to teams_url, notice: t('notice.update.team')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def search
        if params[:name].blank?
            redirect_to teams_url, alert: t('alert.search.team')
        else
            @pagy, @teams = pagy(Team.where('name LIKE ?', "%" + params[:name] + "%").order(:name, :location), limit: 15)
            @search_params = params[:name]
        end
    rescue Pagy::OverflowError
        redirect_to teams_url(page: 1)
    end

    private

    def set_team
        @team = Team.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to teams_url
    end

    def team_params
        params.require(:team).permit(:team_type, :name, :location)
    end
end
