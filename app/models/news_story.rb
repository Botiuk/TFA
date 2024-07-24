class NewsStory < ApplicationRecord
    has_one_attached :cover
    has_rich_text :content

    validates :title, presence: true
end
