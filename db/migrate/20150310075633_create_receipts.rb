class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :name
      t.string :tel
      t.string :address
      t.string :city
      t.string :country
      t.belongs_to :order
      t.timestamps null: false
    end
  end
end
