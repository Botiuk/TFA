# frozen_string_literal: true

FactoryBot.define do
  factory :match_video do
    match { FactoryBot.create(:match) }
    video { FactoryBot.create(:video, video_type: 'match_report') }
  end
end
