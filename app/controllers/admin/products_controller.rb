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

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      flash[:notice] = "產品成功更新"
      redirect_to admin_products_path
    else
      render "edit"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :unit, :price, :description)
  end

end
