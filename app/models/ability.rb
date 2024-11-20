# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :main
    can :read, NewsStory do |news_story|
      !news_story.published_at.nil? && news_story.published_at <= DateTime.now
    end
    can :read, Atribute do |atribute|
      atribute.avaliable == 'present'
    end
    can :read, Video
    can %i[calendar gallery gallery_show], Match
    can :liga_top, FanMatch

    return if user.blank?

    can :show, Match

    if user.role == 'fan'
      can :read, Atribute
      can :show, Fan
    end

    return unless user.role == 'admin'

    can :admin, :main
    can :manage, NewsStory
    can %i[read update search], User
    can :manage, Atribute
    can :manage, Video
    can %i[read create update search], Team
    can %i[read create update search], Stadium
    can %i[read create update], Season
    can %i[read create update], Tournament
    can %i[read create update search], Fan
    can %i[read create update attached_photos deleted_attached_photos], Match
    can %i[create destroy], FanMatch
    can %i[create destroy], MatchVideo
  end
end
