# frozen_string_literal: true

class Stadium < ApplicationRecord
  has_many :matches, dependent: nil

  validates :stadium_name, :loctype, :location_name, presence: true
  validates :stadium_name, uniqueness: { case_sensitive: false, scope: %i[loctype location_name] }

  enum :loctype, { city: 0, town: 1, village: 2 }, prefix: true

  def self.formhelper
    stadia = Stadium.order(:stadium_name, :location_name).pluck(:stadium_name, :id)
    stadia.map do |element|
      element[0] = Stadium.where(id: element[1]).pluck(:stadium_name, :location_name).join(', ')
    end
    stadia
  end
end
