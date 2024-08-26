class Photo < ApplicationRecord
  belongs_to :match

  has_one :season, through: :match

  has_one_attached :image

  validates :photo_date, presence: true
end
