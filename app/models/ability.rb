# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, :main
    can :read, NewsStory do |news_story|
      news_story.published_at != nil && news_story.published_at <= DateTime.now
    end
    can :read, Atribute do |atribute|
      atribute.avaliable == "present"
    end
    can :read, Video

    if user.present?

      if user.role == "fan"
        can :read, Atribute
      end

      if user.role == "admin"
        can :manage, NewsStory
        can [:read, :update, :search], User
        can :manage, Atribute
        can :manage, Video
      end
    end

  end
end
