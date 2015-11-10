class Product < ActiveRecord::Base
  validates_presence_of :name, :unit, :price
  validates_uniqueness_of :name, :message => "你的名稱重複了"
  validates_numericality_of :price, :only_integer => true

  has_many :order_products_ships
  has_many :orders, :through => :order_products_ships
end
