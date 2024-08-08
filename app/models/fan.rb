class Fan < ApplicationRecord
    validates :nickname, presence: true, uniqueness: { case_sensitive: false }
    validates :ontour_start, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
