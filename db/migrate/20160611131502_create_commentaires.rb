class CreateCommentaires < ActiveRecord::Migration
  def self.up
    create_table :commentaires do |t|
      t.integer :commentateur_id
      t.integer :evenement_id
      t.text :commentaire
      t.integer :commentpere_id

      t.timestamps null: false
    end
	add_index :commentaires, :commentateur_id
     add_index :commentaires, :evenement_id
    end
	def self.down
		drop_table :commentaires
	end
end
