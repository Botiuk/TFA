class FanMatch < ApplicationRecord
  belongs_to :fan
  belongs_to :match

  validates :fan_id, uniqueness: { scope: :match_id }
end
