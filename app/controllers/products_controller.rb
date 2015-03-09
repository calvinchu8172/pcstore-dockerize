class ProductsController < ApplicationController
  def index
    
    if params[:category]
      @products = Product.where(category_id: params[:category])
    else
      @products = Product.all
    end 
   
    @categories = Category.all
  end

  def show
  end

end
