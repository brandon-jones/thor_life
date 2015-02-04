class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :created_by
      t.text :body
      t.integer :topic_id
      t.boolean :deleted
      t.integer :deleted_by

      t.timestamps null: false
    end
  end
end
