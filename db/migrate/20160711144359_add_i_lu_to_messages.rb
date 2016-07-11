class AddILuToMessages < ActiveRecord::Migration
	def change
		add_column :messages, :i_lu, :boolean, :default => false
	end

end
