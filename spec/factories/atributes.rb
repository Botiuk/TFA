# frozen_string_literal: true

FactoryBot.define do
  factory :atribute do
    name { Faker::Commerce.product_name }
    price { Faker::Number.number(digits: 3) }
    avaliable { Atribute.avaliables.keys.sample }
  end
end
