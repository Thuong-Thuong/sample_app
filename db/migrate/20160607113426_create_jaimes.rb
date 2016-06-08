class CreateJaimes < ActiveRecord::Migration
  def self.up
    create_table :jaimes do |t|
      t.integer :user_id
      t.integer :evenement_id
      t.boolean :jaime

      t.timestamps null: false
    end
add_index :jaimes, :user_id
     add_index :jaimes, :evenement_id
     add_index :jaimes, [:user_id, :evenement_id],
 :unique => true

  end
    def self.down
       drop_table :jaimes
    end
  
end
