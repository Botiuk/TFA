# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    name { Faker::Book.title }
    youtube_id { Faker::Alphanumeric.alpha(number: 10) }
    video_type { Video.video_types.keys.sample }
  end
end
