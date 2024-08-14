class Team < ApplicationRecord
    has_many :home_team_matches, class_name: 'Match', foreign_key: 'home_team_id'
    has_many :visitor_team_matches, class_name: 'Match', foreign_key: 'visitor_team_id'

    validates :name, :location, presence: true
    validates :name, uniqueness: { case_sensitive: false, scope: [:team_type, :location] }

    private
    
    def self.formhelper
        teams = Team.order(:name, :location).pluck(:name, :id)
        teams.map do |element|
            element[0] = Team.where(id: element[1]).pluck(:name, :location).join(", ")
        end
        return teams
    end
end
