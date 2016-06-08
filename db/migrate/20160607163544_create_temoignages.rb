class CreateTemoignages < ActiveRecord::Migration
  def self.up
    create_table :temoignages do |t|
      t.integer :user_id
      t.integer :pro_id
      t.text :temoignage

      t.timestamps null: false
	end
add_index :temoignages, :user_id
    add_index :temoignages, :pro_id
    

  end
   def self.down
      drop_table :temoignages
   end
end
