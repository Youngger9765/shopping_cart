class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.date :deadline
      t.string :status
      t.string :payment
      t.timestamps null: false
    end
  end
end
