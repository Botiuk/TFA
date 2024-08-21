require 'rails_helper'

RSpec.describe "Matches", type: :request do
  it "cannot GET index and redirects to the sign_in page" do
    get matches_path
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
  end

  it "cannot GET show and redirects to the sign_in page" do
    match = create(:match)
    get match_path(match)
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
  end

  it "cannot GET new and redirects to the sign_in page" do
    get new_match_path
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
  end

  it "cannot GET edit and redirects to the sign_in page" do
    match = create(:match)
    get edit_match_path(match)
    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
  end

  it "can GET calendar" do
    get calendar_path
    expect(response).to be_successful
  end

  it "can GET calendar with params[:season_id]" do
    season = create(:season)
    get calendar_path(season_id: season.id)
    expect(response).to be_successful
  end
end

describe "register user (not admin) management" do
  before :each do
    @user = create(:user, role: ["user", "fan"].sample)
    login_as(@user, :scope => :user)
  end

  it "cannot GET index and redirects to the root page" do
    get matches_path
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to include I18n.t('alert.access_denied')
  end

  it "can GET show" do
    match = create(:match)
    get match_path(match)
    expect(response).to be_successful
  end

  it "cannot GET new and redirects to the root page" do
    get new_match_path
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to include I18n.t('alert.access_denied')
  end

  it "cannot GET edit and redirects to the root page" do
    match = create(:match)
    get edit_match_path(match)
    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to include I18n.t('alert.access_denied')
  end

  it "can GET calendar" do
    get calendar_path
    expect(response).to be_successful
  end

  it "can GET calendar with params[:season_id]" do
    season = create(:season)
    get calendar_path(season_id: season.id)
    expect(response).to be_successful
  end
end

describe "user-admin management" do
  before :each do
    @user = create(:user, role: "admin")
    login_as(@user, :scope => :user)
  end

  it "can GET index" do
    get matches_path
    expect(response).to be_successful
  end

  it "can GET show" do
    match = create(:match)
    get match_path(match)
    expect(response).to be_successful
  end

  it "can GET new" do
    get new_match_path
    expect(response).to be_successful
  end

  it "can POST create" do
    tournament = create(:tournament)
    season = create(:season)
    stadium = create(:stadium)
    team = create(:team)
    post matches_path, params: { match: attributes_for(:match, tournament_id: tournament.id, season_id: season.id, stadium_id: stadium.id, home_team_id: team.id, visitor_team_id: team.id) }
    expect(response).to be_redirect
    follow_redirect!
    expect(flash[:notice]).to include(I18n.t('notice.create.match'))
  end

  it "can GET edit match" do
    match = create(:match)
    get edit_match_path(match)
    expect(response).to be_successful
  end

  it "can PUT update match" do
    match = create(:match, stage: "Summer")
    put match_path(match), params: { match: {stage: "Winter"} }
    expect(match.reload.stage).to eq("Winter")
    expect(response).to redirect_to(match_path(match))
    expect(flash[:notice]).to include(I18n.t('notice.update.match'))
  end

  it "can GET calendar" do
    get calendar_path
    expect(response).to be_successful
  end

  it "can GET calendar with params[:season_id]" do
    season = create(:season)
    get calendar_path(season_id: season.id)
    expect(response).to be_successful
  end
end
