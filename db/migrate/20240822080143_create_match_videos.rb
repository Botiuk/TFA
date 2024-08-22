class CreateMatchVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :match_videos do |t|
      t.references :match, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
