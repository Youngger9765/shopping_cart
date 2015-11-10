class Order < ActiveRecord::Base

  belongs_to :customer

  has_many :order_products_ships
  has_many :products :through => :order_products_ships


end
