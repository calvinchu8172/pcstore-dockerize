class PaymentsController < ApplicationController

  def new
    @order = Order.find(params[:order_id])
    @client_token = Braintree::ClientToken.generate
  end

  def create
    order = Order.find(params[:order_id])

    transaction = OrderTransaction.new(order,
                                       params[:payment_method_nonce])
    transaction.execute
    if transaction.ok?
      order.paid
      redirect_to products_path, success: I18n.t('pay_successful', total_price: order.total_price)
    else
      redirect_to products_path, danger: I18n.t('pay_failed')
    end
  end

end
