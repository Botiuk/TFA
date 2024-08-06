require 'rails_helper'

RSpec.describe "Stadia", type: :request do
  describe "non registered user management" do
    it "cannot GET index and redirects to the sign_in page" do
      get stadia_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET search and redirects to the sign_in page" do
      get stadia_search_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET new and redirects to the sign_in page" do
      get new_stadium_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET edit and redirects to the sign_in page" do
      stadium = create(:stadium)
      get edit_stadium_path(stadium)
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
      get stadia_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET search and redirects to the root page" do
      get stadia_search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET new and redirects to the root page" do
      get new_stadium_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET edit and redirects to the root page" do
      stadium = create(:stadium)
      get edit_stadium_path(stadium)
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
      get stadia_path
      expect(response).to be_successful
    end

    it "can GET search" do
      get stadia_search_path(location_name: "abc")
      expect(response).to be_successful
    end

    it "cannot GET empty search and redirect to index page" do
      get stadia_search_path
      expect(response).to redirect_to(stadia_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.stadium'))
    end

    it "can GET new" do
      get new_stadium_path
      expect(response).to be_successful
    end

    it "can POST create" do
      post stadia_path, params: { stadium: attributes_for(:stadium) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.stadium'))
    end

    it "can GET edit stadium" do
      stadium = create(:stadium)
      get edit_stadium_path(stadium)
      expect(response).to be_successful
    end

    it "can PUT update stadium" do
      stadium = create(:stadium, stadium_name: "Arena Park")
      put stadium_path(stadium), params: { stadium: {stadium_name: "Nacionalny"} }
      expect(stadium.reload.stadium_name).to eq("Nacionalny")
      expect(response).to redirect_to(stadia_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.stadium'))
    end
  end
end
