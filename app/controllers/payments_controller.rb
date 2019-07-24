class PaymentsController < ApplicationController
  before_action :find_order
  before_action :check_order_items_available
  before_action :order_failed?

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    transaction = OrderTransaction.new(@order,
                                       params[:payment_method_nonce])
    transaction.execute
    if transaction.ok?
      @order.pay!
      redirect_to products_path, success: I18n.t('pay_successful', total_price: @order.total_price)
    else
      redirect_to products_path, danger: I18n.t('pay_failed')
    end
  end

  private

  def find_order
    @order = Order.find(params[:order_id])
  end

  def check_order_items_available
    Order.check_order_items_available(@order)
  end

  def order_failed?
    if @order.failed?
      redirect_to order_path(@order), danger: I18n.t('order.failed')
    end
  end

end
