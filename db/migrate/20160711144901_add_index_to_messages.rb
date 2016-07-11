class AddIndexToMessages < ActiveRecord::Migration
  def change
    add_index :messages, :i_lu
  end
end
