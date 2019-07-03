class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def view
  end

  def create
    if save_receipt && save_order
      @receipt.order_id = @order.id
      @receipt.save
      session["cart"] = nil
      
      redirect_to new_payment_path, success: I18n.t("billing_successful")
    else
      
      render :view, danger: I18n.t("billing_failed")
    end
  end

  def checkout
    if @cart.total_price == 0
      redirect_to :back, info: I18n.t("no_product_shopping_first")
    else
      @order_form = OrderForm.new
    end
  end

  def add
    if user_signed_in?
      product = Product.find_by(id: params[:id])

      if product
        @cart.add_item(product.id)
        session["cart"] = @cart.serialize
        redirect_to :back, success: "#{product.name}" + I18n.t("add_cart_successful")
        # Another way of flash message for example.
        # Rails onply provides :notice and :alert.
        # If want to use costomize or fit in Bootstap. Please add add_flash_types :success, :info, :warning, :danger in application controller.
        # flash[:notice] = "#{product.name}" + I18n.t("add_cart_successful")
        # redirect_to :back

      else
        redirect_to :back, danger: I18n.t("no_this_product")
      end

    else
      # redirect_to new_user_session_path, info: I18n.t("log_in_first")
      redirect_to :back, info: I18n.t("log_in_first")
    end
  end

  def clean
    session["cart"] = nil
    redirect_to :back, warning: I18n.t("cart_cleared")
  end

  private

  def cart_params
    params.require(:order_form).permit(receipt: [:name, :tel, :country, :city, :address])
  end

  def save_receipt
    @receipt = Receipt.new(cart_params[:receipt])

    @receipt.valid? #used to debug
    Rails.logger.debug( @receipt.errors.full_messages ) #used to debug

    @receipt.save
  end

  def save_order
    order_items = []
    @cart.items.each do |item|
      hash = { product_id: item.product.id,
               product_name: item.product.name,
               quantity: item.quantity 
             }
      order_items << OrderItem.new(hash)
    end

    @order = Order.new
    @order.user = current_user
    @order.order_items = order_items
    @order.save
  end

end
