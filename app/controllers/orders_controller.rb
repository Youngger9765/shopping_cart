class OrdersController < ApplicationController
  
  def index
    @orders = Order.all
    @order = Order.new
  end 

  def create
    
    @order = Order.new(order_params)
    @order.save

    redirect_to order_path(@order)
  end

  def show
    @order = Order.find(params[:id])

  end

  def update
    @order = Order.find(params[:id])
    Order.find(params[:id]).update(order_params)

    if params[:order][:product_list] && params[:order][:order_number] !=""
      product_list = params[:order][:product_list]
      product_list.shift(1)

      number =params[:order][:order_number].to_i

      product_list.each do|p|
        product_id = p.to_i

        if OrderProductShip.where(:order_id => @order.id).find_by_product_id(product_id)

        else
          OrderProductShip.create( :order_id => params[:id], :product_id => product_id)
        end
        ships = OrderProductShip.where(:order_id => @order.id).find_by_product_id(product_id)
        ships.number = number

        product_price = Product.find(product_id).price

        ships.subtotal = product_price * number
        ships.save!
      end
    end




    redirect_to order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:name, :product_list, :phone, :address)
  end

end
