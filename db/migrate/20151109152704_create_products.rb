class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :unit
      t.integer :price
      t.integer :inventory
      t.timestamps null: false
    end
  end
end
