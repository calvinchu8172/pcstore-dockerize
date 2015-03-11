class CartsController < ApplicationController
  before_action :set_cart

  def view
  end

  def create
    if save_receipt && save_order
      redirect_to new_payment_path, notice: '訂單成立'
    else
      render :view, notice: '訂單未傳送成功'
    end
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
    receipt = Receipt.new(cart_params[:receipt])
    receipt.save
  end

  def save_order
    order_items = []
    @cart.items.each do |item|
      hash = {product_id: item.product.id, quantity: item.quantity }
      order_items << OrderItem.new(hash)
    end
    order = Order.new
    order.user = current_user
    order.order_items = order_items
    order.save
  end

end
