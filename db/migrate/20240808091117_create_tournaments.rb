# frozen_string_literal: true

class CreateTournaments < ActiveRecord::Migration[7.1]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.string :subname
      t.string :group

      t.timestamps
    end
  end
end
