class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :is_enabled, default: false
      t.boolean :is_deleted, default: false
      t.timestamps null: false
    end

    Category.create(name:'玩具')
    Category.create(name:'包包')
    Category.create(name:'高級品')
  end
end
