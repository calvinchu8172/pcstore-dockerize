class CartsController < ApplicationController
  before_action :set_cart

  def view
  end

  def create
    save_receipt
    save_order
    redirect_to new_payment_path, notice: '訂單成立'
  end

  def checkout
    @order_form = OrderForm.new
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

  private
  def cart_params
    params.require(:order_form).permit(receipt: [:name, :tel, :country, :city, :address])
  end

  def save_receipt
  end

  def save_order
  end

end
