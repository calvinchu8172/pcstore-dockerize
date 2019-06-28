class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.boolean :is_online, default: false
      t.string :image
      t.boolean :is_recycled, default: false

      t.timestamps null: false
    end
  end
end
