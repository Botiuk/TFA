class CreateTournaments < ActiveRecord::Migration[7.1]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :subname
      t.string :group

      t.timestamps
    end
  end
end
