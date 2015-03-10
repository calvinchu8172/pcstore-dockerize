class OrderTransaction
  def initialize(order, nonce)
    @order = order
    @nonce = nonce
  end

  def execute
    @result = Braintree::Transaction.sale(
      amount: 1,
      payment_method_nonce: nonce
      )
  end

  def ok?
    @result.success?
  end

  private
    attr_reader :nonce, :order
  
end