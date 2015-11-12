class Order < ActiveRecord::Base

  belongs_to :customer

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

  def product_info
    ships = OrderProductShip.where(:order_id => self.id)
    @order_information = ships.pluck(:product_id,:number,:subtotal)
    
    @info = Hash.new
    @order_information.each do |i|
      @info["#{i[0]}"]={:number => i[1], :subtotal => i[2]}
    end
  end

  def product_detail(p)
    @info["#{p}"]
  end

  def total_price
    ships = OrderProductShip.where(:order_id => self.id)
    ships.to_a.sum(&:subtotal) 
  end
end
