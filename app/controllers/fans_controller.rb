class FansController < ApplicationController
    before_action :authenticate_user!
    before_action :set_fan, only: %i[ edit update show ]
    authorize_resource

    def index
        @pagy, @fans = pagy(Fan.order(:nickname), limit: 15)
    rescue Pagy::OverflowError
        redirect_to fans_url(page: 1)
    end

    def show
        matches_ids = FanMatch.where(fan_id: @fan.id).pluck(:match_id)
        @fan_matches = FanMatch.where(fan_id: @fan.id)
        @matches = Match.includes(:home_team, :visitor_team).where(id: matches_ids).order(start_at: :desc)
        @matches_all = @matches.count + @fan.ontour_start
    end

    def new
        @fan = Fan.new
    end

    def create
        @fan = Fan.new(fan_params)
        if @fan.save
            redirect_to fan_url(@fan), notice: t('notice.create.fan')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @fan.update(fan_params)
            redirect_to fan_url(@fan), notice: t('notice.update.fan')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def search
        if params[:nickname].blank?
            redirect_to fans_url, alert: t('alert.search.fan')
        else
            @pagy, @fans = pagy(Fan.where('nickname LIKE ?', "%" + params[:nickname] + "%").order(:nickname), limit: 15)
            @search_params = params[:nickname]
        end
    rescue Pagy::OverflowError
        redirect_to fans_url(page: 1)
    end

    private

    def set_fan
        @fan = Fan.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to fans_url
    end

    def fan_params
        params.require(:fan).permit(:nickname, :description, :ontour_start)
    end
end
