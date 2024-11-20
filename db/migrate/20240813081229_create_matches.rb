# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.references :season, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.string :stage
      t.references :stadium, null: false, foreign_key: true
      t.datetime :start_at
      t.references :home_team, null: false
      t.integer :home_goal
      t.references :visitor_team, null: false
      t.integer :visitor_goal

      t.timestamps
    end
    add_foreign_key :matches, :teams, column: :home_team_id
    add_foreign_key :matches, :teams, column: :visitor_team_id
  end
end
