require 'rails_helper'

RSpec.describe Match, type: :model do
  it "is valid with valid attributes" do
    match = build(:match)
    expect(match).to be_valid
  end

  it "is not valid without a season" do
    match = build(:match, season_id: nil)
    expect(match).to_not be_valid
  end

  it "is not valid without a tournament" do
    match = build(:match, tournament_id: nil)
    expect(match).to_not be_valid
  end

  it "is not valid without a stadium" do
    match = build(:match, stadium_id: nil)
    expect(match).to_not be_valid
  end

  it "is not valid without a home_team" do
    match = build(:match, home_team_id: nil)
    expect(match).to_not be_valid
  end

  it "is not valid without a visitor_team" do
    match = build(:match, visitor_team_id: nil)
    expect(match).to_not be_valid
  end

  it "is valid without a stage" do
    match = build(:match, stage: nil)
    expect(match).to be_valid
  end

  it "is not valid when a home_goal is less than 0" do
    match = build(:match, home_goal: -1)
    expect(match).to_not be_valid
  end

  it "is not valid when a home_goal is not number" do
    match = build(:match, home_goal: "One")
    expect(match).to_not be_valid
  end

  it "is not valid when a home_goal is decimal" do
    match = build(:match, home_goal: 0.5)
    expect(match).to_not be_valid
  end

  it "is valid when a home_goal is 0" do
    match = build(:match, home_goal: 0)
    expect(match).to be_valid
  end

  it "is valid without a home_goal" do
    match = build(:match, home_goal: nil)
    expect(match).to be_valid
  end

  it "is not valid when a visitor_goal is less than 0" do
    match = build(:match, visitor_goal: -2)
    expect(match).to_not be_valid
  end

  it "is not valid when a visitor_goal is not number" do
    match = build(:match, visitor_goal: "Two")
    expect(match).to_not be_valid
  end

  it "is not valid when a visitor_goal is decimal" do
    match = build(:match, visitor_goal: 0.3)
    expect(match).to_not be_valid
  end

  it "is valid when a visitor_goal is 0" do
    match = build(:match, visitor_goal: 0)
    expect(match).to be_valid
  end

  it "is valid without a visitor_goal" do
    match = build(:match, visitor_goal: nil)
    expect(match).to be_valid
  end
end
