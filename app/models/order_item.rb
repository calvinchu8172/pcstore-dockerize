class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def price
    product.price * quantity
  end
end
