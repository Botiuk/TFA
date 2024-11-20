# frozen_string_literal: true

class CreateAtributes < ActiveRecord::Migration[7.1]
  def change
    create_table :atributes do |t|
      t.string :name
      t.integer :price
      t.integer :avaliable

      t.timestamps
    end
  end
end
