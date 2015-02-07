class CreateUserGameIds < ActiveRecord::Migration
  def change
    create_table :user_game_ids do |t|
      t.integer :game_id
      t.string :in_game_name
      t.integer :user_id
      t.boolean :banned
      t.boolean :permma_banned
      t.boolean :user_verified
      t.integer :verified_by
      t.boolean :banned_by

      t.timestamps null: false
    end
    add_index :user_game_ids, :game_id
  end
end
