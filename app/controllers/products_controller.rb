class ProductsController < ApplicationController
  before_action :set_cart

  def index
    if params[:category]
      @products = Product.where(category_id: params[:category]).page(params[:page]).per(12)
    else
      @products = Product.page(params[:page]).per(12)
    end 
   
    @categories = Category.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

end
