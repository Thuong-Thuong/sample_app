class CreateCommentreponses < ActiveRecord::Migration
  def self.up
    create_table :commentreponses do |t|
      t.integer :reponse_id
      t.text :reponse
      t.integer :repondeur_id
      t.integer :commentpere_id

      t.timestamps null: false
    end
	add_index :commentreponses, :repondeur_id
	add_index :commentreponses, :reponse_id
     add_index :commentreponses, :commentpere_id
    end
	def self.down
		drop_table :commentreponses
	end
end
