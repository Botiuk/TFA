# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FanMatches' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_fan_match_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'can GET liga_top' do
      get liga_top_path
      expect(response).to be_successful
    end
  end

  describe 'register user (not admin) management' do
    before do
      user = create(:user, role: %w[user fan].sample)
      login_as(user, scope: :user)
    end

    it 'cannot GET new and redirects to the root page' do
      get new_fan_match_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'can GET liga_top' do
      get liga_top_path
      expect(response).to be_successful
    end
  end

  describe 'user-admin management' do
    before do
      user = create(:user, role: 'admin')
      login_as(user, scope: :user)
    end

    it 'can GET new with params match_id' do
      match = create(:match)
      get new_fan_match_path(match_id: match.id)
      expect(response).to be_successful
    end

    it 'can GET new with params fan_id' do
      fan = create(:fan)
      get new_fan_match_path(fan_id: fan.id)
      expect(response).to be_successful
    end

    it 'cannot GET new without params and redirect to matches_path' do
      get new_fan_match_path
      expect(response).to redirect_to(matches_path)
    end

    it 'can POST create' do
      match = create(:match)
      fan = create(:fan)
      post fan_matches_path, params: { fan_match: attributes_for(:fan_match, match_id: match.id, fan_id: fan.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.fan_match'))
    end

    it 'can GET liga_top' do
      get liga_top_path
      expect(response).to be_successful
    end

    it 'can DELETE destroy fan_match' do
      match = create(:match)
      fan_match = create(:fan_match, match_id: match.id)
      delete fan_match_path(fan_match)
      expect(response).to redirect_to(match_path(match))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.fan_match_from_match'))
    end

    it 'can DELETE destroy fan_match with params from == fan' do
      fan = create(:fan)
      fan_match = create(:fan_match, fan_id: fan.id)
      delete fan_match_path(fan_match, from: 'fan')
      expect(response).to redirect_to(fan_path(fan))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.fan_match_from_fan'))
    end
  end
end
