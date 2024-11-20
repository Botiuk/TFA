# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :youtube_id
      t.integer :video_type

      t.timestamps
    end
  end
end
