class CreateSignalevens < ActiveRecord::Migration
  def self.up
    create_table :signalevens do |t|
      t.integer :id_signaleur
      t.text :signalement
      t.boolean :validation, :default => false
      t.integer :even_id

      t.timestamps null: false
    end
	
    	add_index :signalevens, :id_signaleur
	add_index :signalevens, :even_id

  end
  def self.down
    drop_table :signalevens 
  end
	
  
end
