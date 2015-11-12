class ProductsController < ApplicationController

  before_action :find_product, :only => [:show, :update, :destroy]
  
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "產品新增成功"
      redirect_to products_path
    else
      flash[:alert] = "產品新增失敗，檢查一下名稱是否重複，價格必須為阿拉伯數字，單位正確嗎？"
      render "new"
    end

  end

  def show
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "產品成功更新"
      redirect_to products_path
    else
      flash[:alert] = "產品成功失敗，檢查一下名稱是否重複，價格必須為阿拉伯數字，單位正確嗎？"
      render "edit"
    end
  end

  def destroy
    @product.delete
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :unit, :price, :description)
  end

  def find_product
    @product = Product.find(params[:id])
  end

end
