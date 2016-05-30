class CreateEvenements < ActiveRecord::Migration
  def self.up
    create_table :evenements do |t|
      t.integer :user_id
      t.string :titre
      t.text :description
      t.string :lieu_evenmt
      t.datetime :date_evenmt
      t.string :lieu_rdv
      t.datetime :date_rdv
      t.string :prix
      t.integer :nbmax
      t.string :statut
      t.text :theme
      t.text :mot_cle

      t.timestamps null: false
    end
    add_index :evenements, :user_id
  end
  def self.down
    drop_table :evenements 
  end
end
