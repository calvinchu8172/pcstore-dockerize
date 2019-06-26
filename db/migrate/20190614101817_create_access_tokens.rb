class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.references :user, index: true, foreign_key: true
      t.text :property

      t.timestamps null: false
    end
  end
end
