# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :name, null: false
      t.string :youtube_id, null: false
      t.integer :video_type, null: false

      t.timestamps
    end
    add_index :videos, :youtube_id, unique: true
  end
end
