# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MatchVideos' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_match_video_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'register user (not admin) management' do
    before do
      user = create(:user, role: %w[user fan].sample)
      login_as(user, scope: :user)
    end

    it 'cannot GET new and redirects to the root page' do
      get new_match_video_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.access_denied')
    end
  end

  describe 'user-admin management' do
    let(:match) { create(:match) }
    let(:video) { create(:video) }

    before do
      user = create(:user, role: 'admin')
      login_as(user, scope: :user)
    end

    it 'can GET new with params match_id' do
      get new_match_video_path(match_id: match.id)
      expect(response).to be_successful
    end

    it 'can GET new with params video_id' do
      get new_match_video_path(video_id: video.id)
      expect(response).to be_successful
    end

    it 'cannot GET new without params and redirect to matches_path' do
      get new_match_video_path
      expect(response).to redirect_to(matches_path)
    end

    it 'can POST create' do
      post match_videos_path,
           params: { match_video: attributes_for(:match_video, match_id: match.id, video_id: video.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.match_video'))
    end

    it 'can DELETE destroy match_video' do
      match_video = create(:match_video, match_id: match.id)
      delete match_video_path(match_video)
      expect(response).to redirect_to(match_path(match))
      expect(flash[:notice]).to include(I18n.t('notice.destroy.match_video'))
    end
  end
end
