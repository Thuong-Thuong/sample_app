class CreateInscriptions < ActiveRecord::Migration
  def self.up
    create_table :inscriptions do |t|
      t.integer :user_id
      t.integer :evenement_id
      t.string :etat
      t.string :aime

      t.timestamps null: false
    end
	add_index :inscriptions, :user_id
     add_index :inscriptions, :evenement_id
     add_index :inscriptions, [:user_id, :evenement_id],
 :unique => true

  end
    def self.down
       drop_table :inscriptions
    end
end
