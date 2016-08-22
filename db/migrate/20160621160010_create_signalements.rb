class CreateSignalements < ActiveRecord::Migration
  def self.up
    create_table :signalements do |t|
      t.integer :id_signaleur
      t.text :signalement
      t.boolean :validation, :default => false

      t.timestamps null: false
    end
	
    add_index :signalements, :id_signaleur
  end
  def self.down
    drop_table :signalements 
  end

end
