class Match < ApplicationRecord
  belongs_to :season
  belongs_to :tournament
  belongs_to :stadium
  belongs_to :home_team, class_name: 'Team'
  belongs_to :visitor_team, class_name: 'Team'

  validates :home_goal, :visitor_goal, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :start_at, presence: true
end
