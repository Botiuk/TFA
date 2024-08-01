class Video < ApplicationRecord
    validates :name, :youtube_id, :video_type, presence: true
    
    enum :video_type, { chant: 0, match_report: 1 }, prefix: true
end
