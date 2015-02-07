class CreateGameInstances < ActiveRecord::Migration
  def change
    create_table :game_instances do |t|
      t.integer :game_id
      t.string :server_name
      t.string :server_address
      t.integer :server_port
      t.text :mod_list

      t.timestamps null: false
    end
    add_index :game_instances, :game_id
  end
end
