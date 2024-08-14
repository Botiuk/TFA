class Tournament < ApplicationRecord
    has_many :matches

    validates :name, presence: true

    private
    
    def self.formhelper
        tournaments = Tournament.order(:name, :subname, :group).pluck(:name, :id)
        tournaments.map do |element|
            element[0] = Tournament.where(id: element[1]).pluck(:name, :subname, :group).join(". ")
        end
        return tournaments
    end
end
