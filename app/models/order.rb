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

  def product_number(p)
    ships = OrderProductShip.where(:order_id => self.id).find_by_product_id(p.id)
    number = ships.number
  end

  def product_subtotal(p)
    ships = OrderProductShip.where(:order_id => self.id).find_by_product_id(p.id)
    subtotal = ships.subtotal 
  end

  def total_price
    ships = OrderProductShip.where(:order_id => self.id)
    ships.to_a.sum(&:subtotal) 
  end
end
