# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :home_team_matches, class_name: 'Match',
                               foreign_key: 'home_team_id',
                               dependent: nil,
                               inverse_of: :team
  has_many :visitor_team_matches, class_name: 'Match',
                                  foreign_key: 'visitor_team_id',
                                  dependent: nil,
                                  inverse_of: :team

  validates :name, :location, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[team_type location] }

  def self.formhelper
    teams = Team.order(:name, :location).pluck(:name, :id)
    teams.map do |element|
      element[0] = Team.where(id: element[1]).pluck(:name, :location).join(', ')
    end
    teams
  end
end
