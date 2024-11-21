# frozen_string_literal: true

class CreateFans < ActiveRecord::Migration[7.1]
  def change
    create_table :fans do |t|
      t.string :nickname, null: false
      t.integer :ontour_start, default: 0
      t.text :description

      t.timestamps
    end
    add_index :fans, 'lower(nickname)', unique: true
  end
end
