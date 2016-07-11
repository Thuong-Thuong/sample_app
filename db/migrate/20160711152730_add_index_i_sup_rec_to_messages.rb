class AddIndexISupRecToMessages < ActiveRecord::Migration
  def change
    add_index :messages, :i_sup_rec
  end
end
