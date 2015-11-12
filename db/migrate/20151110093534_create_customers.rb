class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company
      t.integer :company_tax_id
      t.string :name
      t.string :phone
      t.string :address
      t.string :email

      t.timestamps null: false
    end
  end
end
