# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video do
  it 'is valid with valid attributes' do
    video = build(:video)
    expect(video).to be_valid
  end

  it 'is not valid without a name' do
    video = build(:video, name: nil)
    expect(video).not_to be_valid
  end

  it 'is valid with not uniq name' do
    video_one = create(:video)
    video_two = build(:video, name: video_one.name)
    expect(video_two).to be_valid
  end

  it 'is not valid without a youtube_id' do
    video = build(:video, youtube_id: nil)
    expect(video).not_to be_valid
  end

  it 'is not valid with not uniq youtube_id' do
    video_one = create(:video)
    video_two = build(:video, youtube_id: video_one.youtube_id)
    expect(video_two).not_to be_valid
  end

  it 'is valid with not uniq youtube_id, case sensetive true' do
    create(:video, youtube_id: 'UltraS')
    video_two = build(:video, youtube_id: 'uLtRaS')
    expect(video_two).to be_valid
  end

  it 'is not valid without a video_type' do
    video = build(:video, video_type: nil)
    expect(video).not_to be_valid
  end
end
