class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.integer :conversation_id
      t.integer :user_id
      t.timestamps null: false
    end
	add_index :recipients, :conversation_id
	add_index :recipients, :user_id
  end
end
