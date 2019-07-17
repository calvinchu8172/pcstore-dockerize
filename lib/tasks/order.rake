namespace :order do
  task :clear_failed => :environment do
    Order.all.each do |order|
      order.update(is_failed: false)
      order.order_items.each do |order_item|
        order_item.update(
          is_unavailable: false, 
          unavailable_reason: nil, 
          product_price: Product.unscoped.find(order_item.product_id).price
          )

      end
    end
  end
end