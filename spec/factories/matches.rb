FactoryBot.define do
  factory :match do
    season { FactoryBot.create(:season) }
    tournament { FactoryBot.create(:tournament) }
    stage { Faker::Alphanumeric.alpha(number: 5) }
    stadium { FactoryBot.create(:stadium) }
    start_at { Faker::Time.between(from: DateTime.now - 6.month, to: DateTime.now + 6.month) }
    home_team { FactoryBot.create(:team) }
    home_goal { [Faker::Number.number(digits: 1), nil].sample }
    visitor_team { FactoryBot.create(:team) }
    visitor_goal { [Faker::Number.number(digits: 1), nil].sample }
  end
end
