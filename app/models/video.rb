class Video < ApplicationRecord
    has_one :match_video, dependent: :destroy
    
    validates :name, :video_type, presence: true
    validates :youtube_id, presence: true, uniqueness: { case_sensitive: true }    
    
    enum :video_type, { chant: 0, match_report: 1 }, prefix: true
end
