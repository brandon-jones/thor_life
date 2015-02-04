class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :created_by
      t.boolean :sticky, :default => false
      t.integer :order
      t.text :body
      t.boolean :locked, :default => false
      t.boolean :deleted, :default => false
      t.integer :deleted_by
      t.datetime :last_updated
      t.integer :forum_id

      t.timestamps null: false
    end
    add_index :topics, :title
    add_index :topics, :order
    add_index :topics, :sticky
    add_index :topics, :forum_id
    add_index :topics, :last_updated
  end
end
