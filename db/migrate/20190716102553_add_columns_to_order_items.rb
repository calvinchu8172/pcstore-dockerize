class AddColumnsToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :product_price, :integer
    add_column :order_items, :is_unavailable, :boolean, default: false
    add_column :order_items, :unavailable_reason, :string
  end
end
