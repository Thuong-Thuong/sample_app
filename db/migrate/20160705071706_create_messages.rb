class CreateMessages < ActiveRecord::Migration
	def self.up
		create_table :messages do |t|
			t.integer :sender_id
			t.integer :receiver_id
			t.text :message
			t.boolean :lu, :default => 0
			t.timestamps null: false
		end
		add_index :messages, :sender_id
		add_index :messages, :receiver_id
	end
	def self.down
		drop_table :messages
	end
end
