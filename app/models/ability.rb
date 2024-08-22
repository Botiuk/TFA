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
    can :calendar, Match
    can :liga_top, FanMatch

    if user.present?
      can :show, Match

      if user.role == "fan"
        can :read, Atribute       
        can :show, Fan
      end

      if user.role == "admin"
        can :admin, :main
        can :manage, NewsStory
        can [:read, :update, :search], User
        can :manage, Atribute
        can :manage, Video
        can [:read, :create, :update, :search], Team
        can [:read, :create, :update, :search], Stadium
        can [:read, :create, :update], Season
        can [:read, :create, :update], Tournament
        can [:read, :create, :update, :search], Fan
        can [:read, :create, :update], Match
        can [:create, :destroy], FanMatch
        can [:create, :destroy], MatchVideo
      end
    end

  end
end
