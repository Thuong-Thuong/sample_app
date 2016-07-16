class AddcolumnstoProUsers < ActiveRecord::Migration
  def change

	add_column :users, :siteinternet, :string
	add_column :users, :abonnement_statut, :integer
		

  end
end
