class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string, default:'new', limit: 20
  end
end
