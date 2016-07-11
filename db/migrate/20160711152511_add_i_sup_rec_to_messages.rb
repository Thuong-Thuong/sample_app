class AddISupRecToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :i_sup_rec, :boolean, :default => false
  end
end
