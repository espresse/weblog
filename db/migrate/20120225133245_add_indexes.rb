class AddIndexes < ActiveRecord::Migration
  def change
    add_index :tags, :name
    add_index :comments, [:id, :post_id]
  end
end