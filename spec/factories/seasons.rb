# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    random_date = Faker::Date.between(from: 20.years.ago, to: 1.year.ago)
    start_date { random_date }
    end_date { (random_date + rand(2..12).months) }
    name { Faker::Movie.title }
  end
end
