class ProductsController < ApplicationController
  autocomplete :product, :name, extra_data: [:image, :price], full: true, display_value: :funky_method
  autocomplete :product, :id, extra_data: [:name, :image, :price], full: true
  before_action :set_cart

  def index
    @q = Product.ransack(params[:q])
    @data = @q.result(distinct: true)

    if params[:category]
      @products = @data.where(category_id: params[:category]).page(params[:page]).per(12)
    else
      @products = @data.page(params[:page]).per(12)
    end
   
    @categories = Category.all
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

end
