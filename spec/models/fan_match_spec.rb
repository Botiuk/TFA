# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FanMatch do
  it 'is valid with valid attributes' do
    fan_match = build(:fan_match)
    expect(fan_match).to be_valid
  end

  it 'is not valid without a fan' do
    fan_match = build(:fan_match, fan_id: nil)
    expect(fan_match).not_to be_valid
  end

  it 'is not valid without a match' do
    fan_match = build(:fan_match, match_id: nil)
    expect(fan_match).not_to be_valid
  end

  it 'is not valid with same fan and match' do
    fan_match_one = create(:fan_match)
    fan_match_two = build(:fan_match, fan_id: fan_match_one.fan.id, match_id: fan_match_one.match.id)
    expect(fan_match_two).not_to be_valid
  end
end
