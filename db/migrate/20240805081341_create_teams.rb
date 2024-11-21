# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :team_type
      t.string :name, null: false
      t.string :location, null: false

      t.timestamps
    end
    add_index :teams, 'lower(name), "team_type", "location"', unique: true
  end
end
