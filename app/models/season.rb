class Season < ApplicationRecord
    has_many :matches

    validates :name, :start_date, presence: true
    validates :end_date, comparison: { greater_than_or_equal_to: :start_date }, allow_blank: true

    private

    def self.formhelper
        Season.order(name: :desc).pluck(:name, :id)
    end
end
