class Addcolumntoevenements < ActiveRecord::Migration
  def change
	add_column :evenements, :code_postal, :integer
  end
end
