class AddISupToMessages < ActiveRecord::Migration
	def change
		add_column :messages, :i_sup, :boolean, :default => false
	end
end
