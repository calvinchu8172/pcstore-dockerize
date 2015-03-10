require 'test_helper'

class OrderTransactionTest < ActiveSupport::TestCase

  test "transaction with paypal" do
    order = Order.new
    nonce = Braintree::Test::Nonce::Transactable

    transaction = OrderTransaction.new(order, nonce)
    transaction.execute

    assert transaction.ok?    
  end

end