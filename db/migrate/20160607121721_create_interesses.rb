class CreateInteresses < ActiveRecord::Migration
  def self.up
    create_table :interesses do |t|
      t.integer :user_id
      t.integer :evenement_id
      t.boolean :interesse

      t.timestamps null: false
    end
add_index :interesses, :user_id
     add_index :interesses, :evenement_id
     add_index :interesses, [:user_id, :evenement_id],
 :unique => true

  end
    def self.down
       drop_table :interesses
    end

end
