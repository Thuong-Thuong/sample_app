class CreateMessages < ActiveRecord::Migration
	def self.up
		create_table :messages do |t|
			t.integer :sender_id
			t.integer :receiver_id
			t.text :message
			t.integer :i_lu, :default => 0
			t.boolean :i_sup, :default => false
			t.boolean :i_sup_rec, :default => false
			t.timestamps null: false
		end
		add_index :messages, :sender_id
		add_index :messages, :receiver_id
		add_index :messages, :i_lu
		add_index :messages, :i_sup
		add_index :messages, :i_sup_rec
	end
	def self.down
		drop_table :messages
	end
end
