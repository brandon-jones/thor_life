class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :title
      t.integer :price_in_cents
      t.string :perk_ids

      t.timestamps null: false
    end
  end
end
