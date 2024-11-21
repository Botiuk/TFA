# frozen_string_literal: true

class CreateFanMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :fan_matches do |t|
      t.references :fan, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
    add_index :fan_matches, %i[fan_id match_id], unique: true
  end
end
