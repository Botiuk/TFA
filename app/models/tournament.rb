# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :matches, dependent: nil

  validates :name, presence: true

  def self.formhelper
    tournaments = Tournament.order(:name, :subname, :group).pluck(:name, :id)
    tournaments.map do |element|
      element[0] = Tournament.where(id: element[1]).pluck(:name, :subname, :group).join('. ')
    end
    tournaments
  end
end
