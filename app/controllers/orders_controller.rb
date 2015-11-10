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

  def update
    @order = Order.find(params[:id])
    Order.find(params[:id]).update(order_params)

    if params[:order][:product_list]
      product_list = params[:order][:product_list]
      product_list.shift(1)

      product_list.each do|p|
        product_id = p.to_i
        OrderProductShip.create( :order_id => params[:id], :product_id => product_id)
      end
    end

    redirect_to order_path(@order)
  end


  private

  def order_params
    params.require(:order).permit(:name, :product_list)
  end

end
