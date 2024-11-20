# frozen_string_literal: true

class Season < ApplicationRecord
  has_many :matches, dependent: nil

  validates :name, :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true

  def self.formhelper
    Season.order(start_date: :desc, name: :desc).pluck(:name, :id)
  end
end
