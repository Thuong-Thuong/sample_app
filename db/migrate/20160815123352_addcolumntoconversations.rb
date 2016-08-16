class Addcolumntoconversations < ActiveRecord::Migration
  def change
	add_column :conversations, :recipient_id, :integer
	add_index :conversations, :recipient_id
  end
end
