class CreateGroupings < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.string :title

      t.timestamps null: false
    end
    
    add_index :groupings, :title
  end
end
