# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_video, only: %i[edit update destroy]
  authorize_resource

  def index
    @video_type = params[:video_type].presence || 'chant'
    @pagy, @videos = pagy(Video.where(video_type: @video_type).order(created_at: :desc, name: :desc), limit: 5)
    video_ids = Video.where(video_type: @video_type).ids
    @match_with_videos = MatchVideo.where(video_id: video_ids)
  rescue Pagy::OverflowError
    redirect_to videos_url(page: 1)
  end

  def new
    @video = Video.new(video_type: params[:video_type])
  end

  def edit; end

  def create
    @video = Video.new(video_params)
    if @video.save
      if @video.video_type == 'chant'
        redirect_to videos_url(video_type: 'chant'), notice: t('notice.create.chant')
      else
        redirect_to new_match_video_url(video_id: @video.id), notice: t('notice.create.match_report')
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @video.update(video_params)
      if @video.video_type == 'chant'
        redirect_to videos_url(video_type: 'chant'), notice: t('notice.update.chant')
      else
        redirect_to videos_url(video_type: 'match_report'), notice: t('notice.update.match_report')
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    video_type = @video.video_type
    @video.destroy
    if video_type == 'chant'
      redirect_to videos_url(video_type: 'chant'), notice: t('notice.destroy.chant')
    else
      redirect_to videos_url(video_type: 'match_report'), notice: t('notice.destroy.match_report')
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to videos_url
  end

  def video_params
    params.require(:video).permit(:name, :youtube_id, :video_type)
  end
end
