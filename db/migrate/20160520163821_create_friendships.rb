class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status, :default => false

      t.timestamps 
    end
add_index :friendships, :sender_id
    add_index :friendships, :receiver_id
    add_index :friendships, [:sender_id, :receiver_id],
 :unique => true

  end
end
