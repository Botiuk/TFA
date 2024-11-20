# frozen_string_literal: true

class CreateFans < ActiveRecord::Migration[7.1]
  def change
    create_table :fans do |t|
      t.string :nickname
      t.integer :ontour_start, default: 0
      t.text :description

      t.timestamps
    end
  end
end
