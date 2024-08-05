require 'rails_helper'

RSpec.describe "Atributes", type: :request do
  describe "non registered user management" do
    it "can GET index" do
      get atributes_path
      expect(response).to be_successful
    end

    it "can GET show when atribute present" do
      atribute = create(:atribute, avaliable: "present")
      get atribute_path(atribute)
      expect(response).to be_successful
    end

    it "cannot GET show if atribute absent and  redirects to the root page" do
      atribute = create(:atribute, avaliable: "absent")
      get atribute_path(atribute)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET new and redirects to the sign_in page" do
      get new_atribute_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it "cannot GET edit and redirects to the sign_in page" do
      atribute = create(:atribute)
      get edit_atribute_path(atribute)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe "user-user management" do
    before :each do
      @user = create(:user)
      login_as(@user, :scope => :user)
    end

    it "can GET index" do
      get atributes_path
      expect(response).to be_successful
    end

    it "can GET show when atribute present" do
      atribute = create(:atribute, avaliable: "present")
      get atribute_path(atribute)
      expect(response).to be_successful
    end

    it "cannot GET show if atribute absent and  redirects to the root page" do
      atribute = create(:atribute, avaliable: "absent")
      get atribute_path(atribute)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET new and redirects to the root page" do
      get new_atribute_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET edit and redirects to the root page" do
      atribute = create(:atribute)
      get edit_atribute_path(atribute)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe "user-fan management" do
    before :each do
      @user = create(:user, role: "fan")
      login_as(@user, :scope => :user)
    end

    it "can GET index" do
      get atributes_path
      expect(response).to be_successful
    end

    it "can GET show when atribute present" do
      atribute = create(:atribute, avaliable: "present")
      get atribute_path(atribute)
      expect(response).to be_successful
    end

    it "can GET show when atribute absent" do
      atribute = create(:atribute, avaliable: "absent")
      get atribute_path(atribute)
      expect(response).to be_successful
    end

    it "cannot GET new and redirects to the root page" do
      get new_atribute_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it "cannot GET edit and redirects to the root page" do
      atribute = create(:atribute)
      get edit_atribute_path(atribute)
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
      get atributes_path
      expect(response).to be_successful
    end

    it "can GET new" do
      get new_atribute_path
      expect(response).to be_successful
    end

    it "can POST create" do
      post atributes_path, params: { atribute: attributes_for(:atribute) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.atribute'))
    end

    it "can GET show when atribute present" do
      atribute = create(:atribute, avaliable: "present")
      get atribute_path(atribute)
      expect(response).to be_successful
    end

    it "can GET show when atribute absent" do
      atribute = create(:atribute, avaliable: "absent")
      get atribute_path(atribute)
      expect(response).to be_successful
    end

    it "can GET edit atribute" do
      atribute = create(:atribute)
      get edit_atribute_path(atribute)
      expect(response).to be_successful
    end

    it "can PUT update atribute" do
      atribute = create(:atribute, name: "Scarf")
      put atribute_path(atribute), params: { atribute: {name: "Stickers"} }
      expect(atribute.reload.name).to eq("Stickers")
      expect(response).to redirect_to(atribute_path(atribute))
      expect(flash[:notice]).to include(I18n.t('notice.update.atribute'))
    end

    it "can DELETE destroy atribute" do
      atribute = create(:atribute)
      delete atribute_path(atribute)
      expect(response).to redirect_to(atributes_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.atribute'))
    end
  end
end
