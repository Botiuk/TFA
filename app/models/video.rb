class Video < ApplicationRecord
    has_one :match_video, dependent: :destroy
    
    validates :name, :video_type, presence: true
    validates :youtube_id, presence: true, uniqueness: { case_sensitive: true }    
    
    enum :video_type, { chant: 0, match_report: 1 }, prefix: true

    private
    
    def self.formhelper
        video_with_match_ids = MatchVideo.pluck(:video_id)
        Video.where(video_type: "match_report").where.not(id: video_with_match_ids).order(created_at: :desc, name: :desc).pluck(:name, :id)
    end
end
