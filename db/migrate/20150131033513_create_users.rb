class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.boolean :email_verified, :default => false
      t.string :phone_number
      t.string :phone_provider
      t.text :about_me
      t.boolean :banned, :default => false
      t.boolean :permma_banned, :default => false
      t.integer :banned_by
      t.string :customer_id

      t.timestamps null: false
    end
    add_index :users, :username
    add_index :users, :email
  end
end
