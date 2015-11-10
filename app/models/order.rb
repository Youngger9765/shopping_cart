class Order < ActiveRecord::Base

  has_many :order_products_ships
  has_many :products, :through => :order_products_ships


end
