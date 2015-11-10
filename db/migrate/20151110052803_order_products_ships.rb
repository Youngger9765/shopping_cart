class OrderProductsShips < ActiveRecord::Migration
  def change
    create_table :order_product_ships do |t|
      t.integer :order_id
      t.integer :product_id
      t.timestamps null: false
    end
  end
end
