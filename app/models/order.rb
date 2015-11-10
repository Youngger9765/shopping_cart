class Order < ActiveRecord::Base

  has_many :order_product_ships
  has_many :products, :through => :order_product_ships

  def product_list
    self.products.map{|p| p.name}
  end

  def product_list=(str)
    arr = str.split(",")
  
    self.products = arr.map do |p|
      product = products.find_by_name(p)
      product
    end
  end

end
