class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.text :body
      t.integer :sender_id
      t.string :body_html
      t.timestamps null: false
    end
	add_index :conversations, :sender_id
  end
end
