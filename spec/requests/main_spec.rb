require 'rails_helper'

RSpec.describe "main", type: :request do
  describe "non registered user management" do
    it "can GET index" do
      get root_path
      expect(response).to be_successful
    end

    it "cannot GET admin and redirects to the root page" do
      get admin_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe "registered user (not admin) management" do
    before :each do
      @user = create(:user, role: ["user", "fan"].sample)
      login_as(@user, :scope => :user)
    end

    it "can GET index" do
      get root_path
      expect(response).to be_successful
    end

    it "cannot GET admin and redirects to the root page" do
      get admin_path
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
      get root_path
      expect(response).to be_successful
    end

    it "can GET admin" do
      get admin_path
      expect(response).to be_successful
    end
  end
end

