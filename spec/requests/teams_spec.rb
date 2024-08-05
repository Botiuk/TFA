require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe "non registered user management" do
    it "cannot GET index and redirects to the sign_in page" do
      get teams_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET search and redirects to the sign_in page" do
      get teams_search_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET new and redirects to the sign_in page" do
      get new_team_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET edit and redirects to the sign_in page" do
      team = create(:team)
      get edit_team_path(team)
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
      get teams_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET search and redirects to the root page" do
      get teams_search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET new and redirects to the root page" do
      get new_team_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET edit and redirects to the root page" do
      team = create(:team)
      get edit_team_path(team)
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
      get teams_path
      expect(response).to be_successful
    end

    it "can GET search" do
      get teams_search_path(name: "abc")
      expect(response).to be_successful
    end

    it "cannot GET empty search and redirect to index page" do
      get teams_search_path
      expect(response).to redirect_to(teams_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.team'))
    end

    it "can GET new" do
      get new_team_path
      expect(response).to be_successful
    end

    it "can POST create" do
      post teams_path, params: { team: attributes_for(:team) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.team'))
    end

    it "can GET edit team" do
      team = create(:team)
      get edit_team_path(team)
      expect(response).to be_successful
    end

    it "can PUT update team" do
      team = create(:team, name: "Dynamo")
      put team_path(team), params: { team: {name: "Karpaty"} }
      expect(team.reload.name).to eq("Karpaty")
      expect(response).to redirect_to(teams_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.team'))
    end
  end
end
