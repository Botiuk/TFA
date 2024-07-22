require 'rails_helper'

RSpec.describe "main", type: :request do
  describe "non registered user management" do
    it "can GET index" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "registered user management" do
    before :each do
      @user = create(:user)
      login_as(@user, :scope => :user)
    end

    it "can GET index" do
      get root_path
      expect(response).to be_successful
    end
  end
end

