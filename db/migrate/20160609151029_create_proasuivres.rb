class CreateProasuivres < ActiveRecord::Migration
  def self.up
    create_table :proasuivres do |t|
      t.integer :user_id
      t.integer :pro_id
      t.boolean :asuivre

      t.timestamps null: false
    end
   	add_index :proasuivres, :user_id
     add_index :proasuivres, :pro_id
     add_index :proasuivres, [:user_id, :pro_id],
 	:unique => true

  end
  def self.down
     drop_table :proasuivres
  end
end
