# frozen_string_literal: true

class CreateStadia < ActiveRecord::Migration[7.1]
  def change
    create_table :stadia do |t|
      t.string :country
      t.string :region
      t.string :district
      t.integer :loctype
      t.string :location_name
      t.string :address
      t.string :stadium_name

      t.timestamps
    end
  end
end
