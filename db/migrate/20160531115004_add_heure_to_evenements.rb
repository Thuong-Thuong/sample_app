class AddHeureToEvenements < ActiveRecord::Migration
  def self.up
    add_column :evenements, :heure_evenmt, :time
  end
end
