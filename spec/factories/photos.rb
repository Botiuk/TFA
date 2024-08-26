FactoryBot.define do
  factory :photo do
    photo_date { Faker::Date.between(from: 2.years.ago, to: Date.today) }
    description { Faker::Book.title }
    match { FactoryBot.create(:match) }
  end
end
