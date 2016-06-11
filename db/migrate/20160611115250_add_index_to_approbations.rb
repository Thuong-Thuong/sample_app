class AddIndexToApprobations < ActiveRecord::Migration
  def self.up
    add_index :approbations, [:temoignage_id, :approuver_id],
 :unique => true

  end
end
