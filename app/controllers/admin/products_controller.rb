class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    flash[:notice] = "product 新增成功"
    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :unit, :price)
  end

end
