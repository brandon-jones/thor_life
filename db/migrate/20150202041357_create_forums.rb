class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.integer :parent_id
      t.integer :row_order
      t.integer :created_by
      t.string :title
      t.integer :deleted_by
      t.integer :grouping_id
      t.boolean :locked, :default => false
      t.boolean :topics_allowed, :default => true
      t.boolean :admins_only, :default => false
      t.boolean :main_feed, :default => false
      t.boolean :deleted, :default => false
      t.datetime :last_updated
      t.integer :game_id
      t.integer :game_instance_id

      t.timestamps null: false
    end
    add_index :forums, :row_order
    add_index :forums, :title
    add_index :forums, :grouping_id
    add_index :forums, :last_updated
  end
end
