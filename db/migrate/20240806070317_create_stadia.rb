# frozen_string_literal: true

class CreateStadia < ActiveRecord::Migration[7.1]
  def change
    create_table :stadia do |t|
      t.string :country
      t.string :region
      t.string :district
      t.integer :loctype, null: false
      t.string :location_name, null: false
      t.string :address
      t.string :stadium_name, null: false

      t.timestamps
    end
    add_index :stadia, 'lower(stadium_name), "loctype", "location_name"', unique: true
  end
end
