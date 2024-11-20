# frozen_string_literal: true

FactoryBot.define do
  factory :fan_match do
    fan { FactoryBot.create(:fan) }
    match { FactoryBot.create(:match, match_type: 'ontour') }
  end
end
