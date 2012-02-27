class AddAFewMoreIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :user_id
    add_index :posts, :user_id
  end
end