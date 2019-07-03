class PaymentsController < ApplicationController
  before_action :set_cart

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    order = current_user.orders.last # 這邊要修改成當下的訂單，老師是為了示範隨意指定
    transaction = OrderTransaction.new(order,
                                       params[:payment_method_nonce])
    transaction.execute
    if transaction.ok?
      order.paid
      redirect_to products_path, success: I18n.t('pay_successful', payment: order.total_price)
    else
      redirect_to products_path, danger: I18n.t('pay_failed')
    end
  end
end
