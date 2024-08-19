FactoryBot.define do
  factory :fan_match do
    fan { FactoryBot.create(:fan) }
    match { FactoryBot.create(:match) }
  end
end
