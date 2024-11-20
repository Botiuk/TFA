# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :season
  belongs_to :tournament
  belongs_to :stadium
  belongs_to :home_team, class_name: 'Team'
  belongs_to :visitor_team, class_name: 'Team'

  has_many :fan_matches, dependent: nil
  has_many :match_videos, dependent: nil

  has_many_attached :photos

  validates :home_goal, :visitor_goal, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
                                       allow_nil: true
  validates :start_at, :match_type, presence: true

  enum :match_type, { home: 0, ontour: 1, friendly: 2 }, prefix: true

  def self.formhelper(match_type)
    matches = Match.where(match_type: match_type).order(start_at: :desc).pluck(:start_at, :id)
    matches.map do |element|
      match = Match.includes(:home_team, :visitor_team).where(id: element[1]).first
      element[0] =
        "#{I18n.l(match.start_at, format: :only_date)} | #{match.home_team.name} - #{match.visitor_team.name}"
    end
    matches
  end

  def self.season_matches(season_id)
    Match.includes(:home_team, :visitor_team).where(season_id: season_id).order(start_at: :asc)
  end
end
