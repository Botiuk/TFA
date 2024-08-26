require 'rails_helper'

RSpec.describe Photo, type: :model do
  it "is valid with valid attributes" do
    photo = build(:photo)
    expect(photo).to be_valid
  end

  it "is not valid without a photo_date" do
    photo = build(:photo, photo_date: nil)
    expect(photo).to_not be_valid
  end

  it "is valid without description" do
    photo = build(:photo, description: nil)
    expect(photo).to be_valid
  end

  it "is not valid without a match" do
    photo = build(:photo, match_id: nil)
    expect(photo).to_not be_valid
  end
end
