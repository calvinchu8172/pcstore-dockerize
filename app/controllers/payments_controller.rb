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
      redirect_to products_path, notice:'付款成功！謝謝您！歡迎再度光臨！'
    else
      redirect_to products_path, notice:'付款發生錯誤！'
    end
  end
end
