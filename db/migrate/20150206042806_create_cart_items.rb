class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.string :item_type
      t.integer :price_in_cents
      t.integer :cart_id

      t.timestamps null: false
    end
    add_index :cart_items, :item_id
  end
end
