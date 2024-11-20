# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Atribute do
  it 'is valid with valid attributes' do
    atribute = build(:atribute)
    expect(atribute).to be_valid
  end

  it 'is not valid without a name' do
    atribute = build(:atribute, name: nil)
    expect(atribute).not_to be_valid
  end

  it 'is valid with not uniq name' do
    atribute_one = create(:atribute)
    atribute_two = build(:atribute, name: atribute_one.name)
    expect(atribute_two).to be_valid
  end

  it 'is not valid without a price' do
    atribute = build(:atribute, price: nil)
    expect(atribute).not_to be_valid
  end

  it 'is not valid when a price is less than 0' do
    atribute = build(:atribute, price: -1)
    expect(atribute).not_to be_valid
  end

  it 'is not valid when a price is not number' do
    atribute = build(:atribute, price: 'Ten')
    expect(atribute).not_to be_valid
  end

  it 'is not valid when a price is not integer' do
    atribute = build(:atribute, price: 1.5)
    expect(atribute).not_to be_valid
  end

  it 'is not valid without a avaliable' do
    atribute = build(:atribute, avaliable: nil)
    expect(atribute).not_to be_valid
  end

  it 'is valid without a photo' do
    atribute = build(:atribute, atribute_photos: nil)
    expect(atribute).to be_valid
  end
end
