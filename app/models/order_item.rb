class OrderItem < ActiveRecord::Base
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  belongs_to :order
  belongs_to :product

  def price
    product.price * quantity
  end
end
