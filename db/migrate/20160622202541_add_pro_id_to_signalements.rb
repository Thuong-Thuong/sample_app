class AddProIdToSignalements < ActiveRecord::Migration
  def self.up
    add_column :signalements, :pro_id, :integer
	add_index :signalements, :pro_id
  end
end
