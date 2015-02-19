class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :total_in_cents
      t.boolean :delivered, :default => false
      t.integer :delivered_by
      t.datetime :delivered_on
      t.integer :donation_id

      t.timestamps null: false
    end
  end
end
