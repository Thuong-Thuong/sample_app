class Addcolumntomessages < ActiveRecord::Migration
  def change
	add_column :messages, :i_sup, :integer, :default =>0
	add_column :messages, :i_lu, :integer, :default =>0
	add_column :messages, :i_sup_rec, :integer, :default =>0
  end
end
