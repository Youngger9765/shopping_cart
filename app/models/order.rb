class Order < ActiveRecord::Base

  has_many :order_product_ships
  has_many :products, :through => :order_product_ships

  def order_number
  end

  def total_product_number
    self.order_product_ships.size
  end

  def product_list
    self.products.map{|p| p.name}
  end

  def product_info(p,info)
    ships = OrderProductShip.where("order_id =? AND product_id = ?", self.id,p.id)
    information = ships.pluck(:"#{info}")[0]
  end

  def total_price
    ships = OrderProductShip.where(:order_id => self.id)
    ships.to_a.sum(&:subtotal) 
  end
end
