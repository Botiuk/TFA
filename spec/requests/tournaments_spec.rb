# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tournaments' do
  describe 'non registered user management' do
    it 'cannot GET index and redirects to the sign_in page' do
      get tournaments_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_tournament_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      tournament = create(:tournament)
      get edit_tournament_path(tournament)
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
      get tournaments_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET new and redirects to the root page' do
      get new_tournament_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET edit and redirects to the root page' do
      tournament = create(:tournament)
      get edit_tournament_path(tournament)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe 'user-admin management' do
    before do
      user = create(:user, role: 'admin')
      login_as(user, scope: :user)
    end

    it 'can GET index' do
      get tournaments_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_tournament_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post tournaments_path, params: { tournament: attributes_for(:tournament) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.tournament'))
    end

    it 'can GET edit tournament' do
      tournament = create(:tournament)
      get edit_tournament_path(tournament)
      expect(response).to be_successful
    end

    it 'can PUT update tournament' do
      tournament = create(:tournament, name: 'World Cup')
      put tournament_path(tournament), params: { tournament: { name: 'Champions Legue' } }
      expect(tournament.reload.name).to eq('Champions Legue')
      expect(response).to redirect_to(tournaments_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.tournament'))
    end
  end
end
