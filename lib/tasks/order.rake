namespace :order do
  task :update => :environment do
    Order.all.each do |order|
      order.update(state: 'new')
      order.order_items.each do |order_item|
        order_item.update(
          is_unavailable: false, 
          unavailable_reason: nil, 
          product_price: Product.unscoped.find(order_item.product_id).price
          )

      end
    end
    puts '***updated***'
  end
end