require 'test_helper'

class CartItemTest< ActiveSupport::TestCase
  test "calculate cart item price" do
    p1 = Product.create(name:'hh', price: 10)

    cart = Cart.new
    5.times { cart.add_item(p1.id) }

    assert_equal 50, cart.items.first.price
  end
end
