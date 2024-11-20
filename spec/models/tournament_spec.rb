# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament do
  it 'is valid with valid attributes' do
    tournament = build(:tournament)
    expect(tournament).to be_valid
  end

  it 'is not valid without a name' do
    tournament = build(:tournament, name: nil)
    expect(tournament).not_to be_valid
  end

  it 'is valid without a subname' do
    tournament = build(:tournament, subname: nil)
    expect(tournament).to be_valid
  end

  it 'is valid without a group' do
    tournament = build(:tournament, group: nil)
    expect(tournament).to be_valid
  end
end
