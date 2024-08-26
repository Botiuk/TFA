class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.date :photo_date
      t.string :description
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
