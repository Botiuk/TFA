require 'rails_helper'

RSpec.describe "Seasons", type: :request do
  describe "non registered user management" do
    it "cannot GET index and redirects to the sign_in page" do
      get seasons_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET new and redirects to the sign_in page" do
      get new_season_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET edit and redirects to the sign_in page" do
      season = create(:season)
      get edit_season_path(season)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe "register user (not admin) management" do
    before :each do
      @user = create(:user, role: ["user", "fan"].sample)
      login_as(@user, :scope => :user)
    end

    it "cannot GET index and redirects to the root page" do
      get seasons_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET new and redirects to the root page" do
      get new_season_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET edit and redirects to the root page" do
      season = create(:season)
      get edit_season_path(season)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe "user-admin management" do
    before :each do
      @user = create(:user, role: "admin")
      login_as(@user, :scope => :user)
    end

    it "can GET index" do
      get seasons_path
      expect(response).to be_successful
    end

    it "can GET new" do
      get new_season_path
      expect(response).to be_successful
    end

    it "can POST create" do
      post seasons_path, params: { season: attributes_for(:season) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.season'))
    end

    it "cannot POST create if end_date nil and now is one season with end_date nil" do
      season_one = create(:season, end_date: nil)
      post seasons_path, params: { season: attributes_for(:season, end_date: nil) }
      expect(flash[:alert]).to include(I18n.t('alert.create.season'))
      expect(response).to have_http_status(422)
    end

    it "can GET edit season" do
      season = create(:season)
      get edit_season_path(season)
      expect(response).to be_successful
    end

    it "can PUT update season" do
      season = create(:season, name: "Season 007")
      put season_path(season), params: { season: {name: "Season 911"} }
      expect(season.reload.name).to eq("Season 911")
      expect(response).to redirect_to(seasons_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.season'))
    end

    it "can PUT update season with change end_date to nil if now is no one season with end_date nil" do
      season = create(:season)
      put season_path(season), params: { season: {end_date: nil} }
      expect(season.reload.end_date).to eq(nil)
      expect(response).to redirect_to(seasons_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.season'))
    end

    it "can PUT update season with end_date to nil when do not change end_date" do
      season = create(:season, name: "Season 007", end_date: nil)
      put season_path(season), params: { season: {name: "Season 911"} }
      expect(season.reload.name).to eq("Season 911")
      expect(response).to redirect_to(seasons_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.season'))
    end

    it "cannot PUT update season with change end_date to nil if now is one season with end_date nil" do
      season_one = create(:season, end_date: nil)
      my_date = Date.today
      season = create(:season, start_date: my_date, end_date: my_date)
      put season_path(season), params: { season: {start_date: (my_date - 1.month), end_date: nil} }
      expect(flash[:alert]).to include(I18n.t('alert.update.season'))
      expect(response).to have_http_status(422)
      expect(season.reload.start_date).to eq(my_date)
      expect(season.reload.end_date).to eq(my_date)
    end
  end
end
