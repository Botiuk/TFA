# frozen_string_literal: true

class MatchVideo < ApplicationRecord
  belongs_to :match
  belongs_to :video

  validates :video_id, uniqueness: true
end
