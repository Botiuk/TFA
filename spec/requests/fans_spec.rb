# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fans' do
  describe 'non registered user management' do
    it 'cannot GET index and redirects to the sign_in page' do
      get fans_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET search and redirects to the sign_in page' do
      get fans_search_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET show and redirects to the sign_in page' do
      fan = create(:fan)
      get fan_path(fan)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_fan_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      fan = create(:fan)
      get edit_fan_path(fan)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'register user (not admin) management' do
    before do
      user = create(:user, role: %w[user fan].sample)
      login_as(user, scope: :user)
    end

    it 'cannot GET index and redirects to the root page' do
      get fans_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET search and redirects to the root page' do
      get fans_search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET new and redirects to the root page' do
      get new_fan_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET edit and redirects to the root page' do
      fan = create(:fan)
      get edit_fan_path(fan)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe 'user-user management' do
    before do
      user = create(:user, role: 'user')
      login_as(user, scope: :user)
    end

    it 'cannot GET show and redirects to the root page' do
      fan = create(:fan)
      get fan_path(fan)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe 'user-fan management' do
    before do
      user = create(:user, role: 'fan')
      login_as(user, scope: :user)
    end

    it 'can GET show' do
      fan = create(:fan)
      get fan_path(fan)
      expect(response).to be_successful
    end
  end

  describe 'user-admin management' do
    before do
      user = create(:user, role: 'admin')
      login_as(user, scope: :user)
    end

    it 'can GET index' do
      get fans_path
      expect(response).to be_successful
    end

    it 'can GET search' do
      get fans_search_path(nickname: 'abc')
      expect(response).to be_successful
    end

    it 'cannot GET empty search and redirect to index page' do
      get fans_search_path
      expect(response).to redirect_to(fans_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.fan'))
    end

    it 'can GET show' do
      fan = create(:fan)
      get fan_path(fan)
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_fan_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post fans_path, params: { fan: attributes_for(:fan) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.fan'))
    end

    it 'can GET edit fan' do
      fan = create(:fan)
      get edit_fan_path(fan)
      expect(response).to be_successful
    end

    it 'can PUT update fan' do
      fan = create(:fan, nickname: 'Myhalu4')
      put fan_path(fan), params: { fan: { nickname: 'Kyzmi4' } }
      expect(fan.reload.nickname).to eq('Kyzmi4')
      expect(response).to redirect_to(fan_path(fan))
      expect(flash[:notice]).to include(I18n.t('notice.update.fan'))
    end
  end
end
