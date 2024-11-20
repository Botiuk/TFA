# frozen_string_literal: true

class Atribute < ApplicationRecord
  has_many_attached :atribute_photos

  validates :name, :avaliable, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  enum :avaliable, { present: 0, absent: 1 }, prefix: true
end
