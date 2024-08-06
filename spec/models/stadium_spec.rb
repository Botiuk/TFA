require 'rails_helper'

RSpec.describe Stadium, type: :model do
  it "is valid with valid attributes" do
    stadium = build(:stadium)
    expect(stadium).to be_valid
  end

  it "is valid without contry" do
    stadium = build(:stadium, country: nil)
    expect(stadium).to be_valid
  end

  it "is valid without region" do
    stadium = build(:stadium, region: nil)
    expect(stadium).to be_valid
  end

  it "is valid without district" do
    stadium = build(:stadium, district: nil)
    expect(stadium).to be_valid
  end

  it "is not valid without a loctype" do
    stadium = build(:stadium, loctype: nil)
    expect(stadium).to_not be_valid
  end

  it "is not valid without a location_name" do
    stadium = build(:stadium, location_name: nil)
    expect(stadium).to_not be_valid
  end

  it "is valid without address" do
    stadium = build(:stadium, address: nil)
    expect(stadium).to be_valid
  end

  it "is not valid without a stadium_name" do
    stadium = build(:stadium, stadium_name: nil)
    expect(stadium).to_not be_valid
  end

  it "is not valid with same stadium_name and same loctype and location_name" do
    stadium_one = create(:stadium)
    stadium_two = build(:stadium, stadium_name: stadium_one.stadium_name, loctype: stadium_one.loctype, location_name: stadium_one.location_name)
    expect(stadium_two).to_not be_valid
  end
end
