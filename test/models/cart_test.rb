require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "add item to cart" do
    cart = Cart.new
    cart.add_item 1

    assert_not cart.empty?
  end

  test "add more same item to cart" do
    cart = Cart.new
    5.times { cart.add_item(1) }

    assert_equal 1, cart.items.count
    assert_equal 5, cart.items.first.quantity
  end

  test "get item from cart" do
    p1 = Product.create(name:'ruby', price:100)
    cart = Cart.new
    cart.add_item(p1.id)
    assert_kind_of Product, cart.items.first.product
  end

  test "build cart from hash" do
    cart = Cart.build_from_hash(items_hash)
    assert_equal 1, cart.items.first.product_id
  end
    
  test "build hash from cart" do
    p1 = Product.create(id:1, name: 'ruby', price:1000)
    cart = Cart.new
    cart.add_item(p1.id)

    assert_equal cart.serialize, items_hash
  end

  private
  def items_hash
    {
      "items" =>
      [
          {"product_id" => 1, "quantity" => 1 }
      ]
    }
  end
end