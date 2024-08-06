class Stadium < ApplicationRecord
    validates :stadium_name, :loctype, :location_name, presence: true
    validates :stadium_name, uniqueness: { case_sensitive: false, scope: [:loctype, :location_name] }

    enum :loctype, { city: 0, town: 1, village: 2 }, prefix: true
end
