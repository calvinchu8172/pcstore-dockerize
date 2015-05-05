class PaymentsController < ApplicationController
  before_action :set_cart

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def create
    order = current_user.orders.last
    transaction = OrderTransaction.new(order,
                                       params[:payment_method_nonce])
    transaction.execute
    if transaction.ok?
      order.paid
      redirect_to products_path, success: I18n.t('pay_successful')
    else
      redirect_to products_path, danger: I18n.t('pay_failed')
    end
  end
end
