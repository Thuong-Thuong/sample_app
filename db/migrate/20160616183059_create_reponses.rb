class CreateReponses < ActiveRecord::Migration
  def self.up
    create_table :reponses do |t|
      t.text :reponse
      t.references :user, index: true, foreign_key: true
      t.references :commentaire, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
