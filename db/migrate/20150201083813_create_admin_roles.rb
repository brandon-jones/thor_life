class CreateAdminRoles < ActiveRecord::Migration
  def change
    create_table :admin_roles do |t|
      t.integer :user_id
      t.string :admin_type
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
