class FanMatchesController < ApplicationController
    before_action :authenticate_user!, except: %i[ liga_top ]
    before_action :set_fan_match, only: %i[ destroy ]
    before_action :my_formhelpers, only: %i[ new create ]
    authorize_resource

    def new
        if params[:match_id].present?
            @fan_match = FanMatch.new(match_id: params[:match_id])
            @match = Match.find(params[:match_id])
        elsif params[:fan_id].present?
            @fan_match = FanMatch.new(fan_id: params[:fan_id])
            @fan = Fan.find(params[:fan_id])
        else
            redirect_to matches_url
        end
    end

    def create
        @fan_match = FanMatch.new(fan_match_params)
        if @fan_match.save
            match = Match.find(@fan_match.match_id)
            redirect_to match_path(match), notice: t('notice.create.fan_match')
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        if params[:from] == "fan"
            fan = Fan.find(@fan_match.fan_id)
            @fan_match.destroy
            redirect_to fan_url(fan), notice: t('notice.destroy.fan_match_from_fan')
        else
            match = Match.find(@fan_match.match_id)
            @fan_match.destroy
            redirect_to match_url(match), notice: t('notice.destroy.fan_match_from_match')
        end
    end


    def liga_top
        @last_update = FanMatch.maximum(:updated_at)
        fan_matches_count = FanMatch.group(:fan_id).count
        @liga_top_fans = Fan.order(:nickname)
        @liga_top_fans.map do |liga_top_fan|
            if fan_matches_count.has_key?(liga_top_fan.id)
                liga_top_fan.ontour_start = liga_top_fan.ontour_start + fan_matches_count.values_at(liga_top_fan.id).join.to_i
            end
        end
    end

    private

    def set_fan_match
        @fan_match = FanMatch.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to fan_matches_url
    end

    def fan_match_params
        params.require(:fan_match).permit(:fan_id, :match_id)
    end

    def my_formhelpers
        @matches = Match.formhelper
        @fans = Fan.formhelper
    end
end
