class FanMatch < ApplicationRecord
  belongs_to :fan
  belongs_to :match

  validates :fan, uniqueness: { scope: :match }
end
