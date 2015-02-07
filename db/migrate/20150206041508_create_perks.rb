class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.string :title
      t.integer :game_instance_id
      t.text :description
      t.integer :price_in_cents
      t.integer :game_id

      t.timestamps null: false
    end
    add_index :perks, :game_id
  end
end
