class Team < ApplicationRecord
    validates :name, :location, presence: true
    validates :name, uniqueness: { case_sensitive: false, scope: [:team_type, :location] }
end
