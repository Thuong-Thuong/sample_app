class ChangeTypeILuInMessages < ActiveRecord::Migration
  def self.up
    change_column :messages, :i_lu, :integer, :default => 0
  end
end
