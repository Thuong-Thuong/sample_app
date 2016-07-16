class AddthemetoProUsers < ActiveRecord::Migration
	def change
		add_column :users, :theme, :text
		add_column :users, :motcle, :text
	end
end
