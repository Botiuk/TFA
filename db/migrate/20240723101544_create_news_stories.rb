# frozen_string_literal: true

class CreateNewsStories < ActiveRecord::Migration[7.1]
  def change
    create_table :news_stories do |t|
      t.string :title
      t.datetime :published_at

      t.timestamps
    end
  end
end
