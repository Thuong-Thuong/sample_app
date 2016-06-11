class CreateApprobations < ActiveRecord::Migration
  def self.up
    create_table :approbations do |t|
      t.integer :temoignage_id
      t.integer :approuver_id
      t.boolean :approuve

      t.timestamps null: false
    end

  	add_index :approbations, :temoignage_id
     add_index :approbations, :approuver_id
	add_index :approbations, [:temoignage_id, :approuver_id],
 :unique => true

     
  end
    def self.down
       drop_table :approbations
    end


end
