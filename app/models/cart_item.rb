class CartItem
  attr_reader :product_id, :quantity

  def initialize(product_id, quantity = 1)
      @product_id = product_id
      @quantity = quantity
  end

  def increment
    @quantity += 1
  end

  def add_quantity(quantity)
    @quantity += quantity
  end

  def product
    Product.find_by(id: product_id)
  end

  def price
    quantity*product.price
  end

end