class OrdersController < ApplicationController
  
  def index
    @orders = Order.all
    @order = Order.new
  end 

  def create
    
    @order = Order.new(order_params)
    @order.save

    if params[:order][:product_list]
      product_list = params[:order][:product_list]
      product_list.shift(1)

      product_list.each do|p|
        product_id = p.to_i
        OrderProductShip.create( :order_id => @order.id, :product_id => product_id)
      end
    end


    redirect_to orders_path
  end

  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:name)
  end

end
