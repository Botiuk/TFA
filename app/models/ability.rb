# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, :main
    can :read, NewsStory do |news_story|
      news_story.published_at != nil && news_story.published_at <= DateTime.now
    end

    if user.present?

      # if user.role == "fan"

      # end

      if user.role == "admin"
        can :manage, NewsStory
        can [:read, :update, :search], User
      end
    end

  end
end
