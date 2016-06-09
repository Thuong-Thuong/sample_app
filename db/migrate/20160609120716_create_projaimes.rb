class CreateProjaimes < ActiveRecord::Migration
  def self.up
    create_table :projaimes do |t|
      t.integer :user_id
      t.integer :pro_id
      t.integer :projaime
      t.timestamps null: false
    end
	add_index :projaimes, :user_id
     add_index :projaimes, :pro_id
     add_index :projaimes, [:user_id, :pro_id],
 	:unique => true

  end
  def self.down
      drop_table :projaimes
  end
end
