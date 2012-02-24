class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id
      t.string :username
      t.string :user_email

      t.timestamps
    end
  end
end
