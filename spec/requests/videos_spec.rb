# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Videos' do
  describe 'non registered user management' do
    it 'can GET index' do
      get videos_path
      expect(response).to be_successful
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_video_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      video = create(:video)
      get edit_video_path(video)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'register user (not admin) management' do
    before do
      user = create(:user, role: %w[user fan].sample)
      login_as(user, scope: :user)
    end

    it 'can GET index' do
      get videos_path
      expect(response).to be_successful
    end

    it 'cannot GET new and redirects to the root page' do
      get new_video_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end

    it 'cannot GET edit and redirects to the root page' do
      video = create(:video)
      get edit_video_path(video)
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
      get videos_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_video_path
      expect(response).to be_successful
    end

    it 'can POST create, video_type chant' do
      post videos_path, params: { video: attributes_for(:video, video_type: 'chant') }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.chant'))
    end

    it 'can POST create, video_type match_report' do
      post videos_path, params: { video: attributes_for(:video, video_type: 'match_report') }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.match_report'))
    end

    it 'can GET edit video' do
      video = create(:video)
      get edit_video_path(video)
      expect(response).to be_successful
    end

    it 'can PUT update video, video_type chant' do
      video = create(:video, name: 'Young fan school', video_type: 'chant')
      put video_path(video), params: { video: { name: 'Song' } }
      expect(video.reload.name).to eq('Song')
      expect(response).to redirect_to(videos_url(video_type: 'chant'))
      expect(flash[:notice]).to include(I18n.t('notice.update.chant'))
    end

    it 'can PUT update video, video_type match_report' do
      video = create(:video, name: 'Last match in seson', video_type: 'match_report')
      put video_path(video), params: { video: { name: 'Fireshow' } }
      expect(video.reload.name).to eq('Fireshow')
      expect(response).to redirect_to(videos_url(video_type: 'match_report'))
      expect(flash[:notice]).to include(I18n.t('notice.update.match_report'))
    end

    it 'can DELETE destroy video, video_type chant' do
      video = create(:video, video_type: 'chant')
      delete video_path(video)
      expect(response).to redirect_to(videos_url(video_type: 'chant'))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.chant'))
    end

    it 'can DELETE destroy video, video_type match_report' do
      video = create(:video, video_type: 'match_report')
      delete video_path(video)
      expect(response).to redirect_to(videos_url(video_type: 'match_report'))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.match_report'))
    end
  end
end
