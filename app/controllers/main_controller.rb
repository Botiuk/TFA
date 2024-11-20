# frozen_string_literal: true

class MainController < ApplicationController
  authorize_resource class: false

  def index
    @news_stories = NewsStory.where.not(published_at: nil).where.not('published_at > ?',
                                                                     DateTime.now).order(published_at: :desc).limit(5)
  end

  def admin; end
end
