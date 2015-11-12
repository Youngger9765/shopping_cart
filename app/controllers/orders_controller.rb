class OrdersController < ApplicationController
  
  before_action :find_order, :only => [:show, :update, :destroy]
  
  def index
    @orders = Order.all
  end 

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save

    redirect_to order_path(@order)
  end

  def show
  end

  def update
    Order.find(params[:id]).update(order_params)

    if params[:order][:product_list] && params[:order][:order_number] !=""
      product_list = params[:order][:product_list]
      product_list.shift(1)

      number =params[:order][:order_number].to_i

      product_list.each do|p|
        product_id = p.to_i

        if product_id == 0
          break
        end  

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

    @order.total = OrderProductShip.where(:order_id => @order.id).to_a.sum(&:subtotal)
    @order.save!

    redirect_to order_path(@order)
  end

  def destroy
    if params[:product_id]
      OrderProductShip.where(:order_id => @order.id).find_by_product_id(params[:product_id]).delete
      redirect_to order_path(@order)
    else
      @order.delete
      redirect_to orders_path
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :product_list, :phone, :address)
  end

end
