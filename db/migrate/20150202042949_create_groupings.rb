class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.string :title
      t.integer :row_order

      t.timestamps null: false
    end
    add_index :groupings, :title
    add_index :groupings, :row_order
  end
end
