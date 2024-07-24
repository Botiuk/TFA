FactoryBot.define do
  factory :news_story do
    title { Faker::Movie.title.capitalize }
    published_at { Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now) }
  end
end
