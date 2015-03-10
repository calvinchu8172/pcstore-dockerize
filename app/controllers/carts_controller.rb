class CartsController < ApplicationController
  before_action :set_cart

  def view
  end

  def add
    product = Product.find_by(id: params[:id])

    if product
      @cart.add_item(product.id)
      session["cart"] = @cart.serialize
      redirect_to :back, notice: "#{product.name} 已加入購物車！"
    else
      redirect_to :back, notice: "查無此商品"
    end
  end

end