# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Season do
  describe 'validations' do
    it 'is valid with valid attributes' do
      season = build(:season)
      expect(season).to be_valid
    end

    it 'is not valid without a name' do
      season = build(:season, name: nil)
      expect(season).not_to be_valid
    end

    it 'is not valid without a start_date' do
      season = build(:season, start_date: nil)
      expect(season).not_to be_valid
    end

    it 'is valid without a end_date' do
      season = build(:season, end_date: nil)
      expect(season).to be_valid
    end

    it 'is not valid when start_date greater than end_date' do
      date_now = Time.zone.today
      season = build(:season, start_date: date_now, end_date: (date_now - 1.day))
      expect(season).not_to be_valid
    end

    it 'is valid when end_date equal start_date' do
      date_now = Time.zone.today
      season = build(:season, start_date: date_now, end_date: date_now)
      expect(season).to be_valid
    end
  end
end
