class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
