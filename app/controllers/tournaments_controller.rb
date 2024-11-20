# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament, only: %i[edit update]
  authorize_resource

  def index
    @pagy, @tournaments = pagy(Tournament.order(:name, :subname, :group), limit: 15)
  rescue Pagy::OverflowError
    redirect_to tournaments_url(page: 1)
  end

  def new
    @tournament = Tournament.new
  end

  def edit; end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to tournaments_url, notice: t('notice.create.tournament')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to tournaments_url, notice: t('notice.update.tournament')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tournaments_url
  end

  def tournament_params
    params.require(:tournament).permit(:name, :subname, :group)
  end
end
