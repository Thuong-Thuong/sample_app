class AddProToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :pro, :boolean, :default => false
  end
  def self.down
    remove_column :users, :pro
  end
end
