# frozen_string_literal: true

class MatchVideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match_video, only: %i[destroy]
  before_action :my_formhelpers, only: %i[new create]
  authorize_resource

  def new
    if params[:match_id].present?
      @match_video = MatchVideo.new(match_id: params[:match_id])
      @match = Match.find(params[:match_id])
    elsif params[:video_id].present?
      @match_video = MatchVideo.new(video_id: params[:video_id])
      @video = Video.find(params[:video_id])
    else
      redirect_to matches_url
    end
  end

  def create
    @match_video = MatchVideo.new(match_video_params)
    if @match_video.save
      match = Match.find(@match_video.match_id)
      redirect_to match_path(match), notice: t('notice.create.match_video')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    match = Match.find(@match_video.match_id)
    @match_video.destroy
    redirect_to match_url(match), notice: t('notice.destroy.match_video')
  end

  private

  def set_match_video
    @match_video = MatchVideo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to matches_url
  end

  def match_video_params
    params.require(:match_video).permit(:video_id, :match_id)
  end

  def my_formhelpers
    @matches = Match.formhelper(%w[home ontour friendly])
    @videos = Video.formhelper
  end
end
