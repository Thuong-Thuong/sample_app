class AddcolumnstoUsers < ActiveRecord::Migration
	def self.up
		add_column :users, :datenaissance, :datetime
		add_column :users, :sexe, :string
		add_column :users, :adresse, :string
		add_column :users, :mobile, :string
		add_column :users, :facebook, :string
		add_column :users, :google, :string
		add_column :users, :twiter, :string
		add_column :users, :linkedin, :string
		add_column :users, :petitmot, :text
		add_column :users, :interet, :text
		add_column :users, :notifmail, :boolean
		add_column :users, :notifsms, :boolean
  end
end







