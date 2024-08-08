FactoryBot.define do
  factory :fan do
    nickname { Faker::Internet.unique.username }
    description { Faker::Lorem.paragraphs }
    ontour_start { Faker::Number.between(from: 0, to: 7) }
  end
end
