class CreateFanMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :fan_matches do |t|
      t.references :fan, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end
  end
end
