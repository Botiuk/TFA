# frozen_string_literal: true

class AddMatchTypeToMatches < ActiveRecord::Migration[7.1]
  def change
    change_table :matches do |t|
      t.integer :match_type
    end
    change_column_null :matches, :match_type, false
  end
end
