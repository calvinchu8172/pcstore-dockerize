class Cart
  attr_reader :items

  def self.build_from_hash(hash)
      items = if hash
        hash["items"].map do |data|
          CartItem.new(data["product_id"], data["quantity"])
        end
      else
        []
      end

      new(items)
  end

  def initialize(items = [])
    @items = items
  end

  def add_item(product_id)
    item = @items.find { |t| t.product_id == product_id }

    if item
      item.increment
    else
      @items << CartItem.new(product_id)
    end
  end

  def empty?
    @items.empty?
  end

  def serialize
    items = @items.map do |item|
      {"product_id" => item.product_id, "quantity" => item.quantity }
    end

    {
      "items" =>items
    }
  end

end

