require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "calculate order total price" do

    p1 = Product.create(name:'gg', price: 100)

    order = Order.create
    order_item = OrderItem.new(product_id: p1.id, quantity: 2, order_id: order.id)
    order.order_items = [order_item]
    order.save

    assert_equal 200, order.total_price
  end
end
