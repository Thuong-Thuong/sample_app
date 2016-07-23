class RemoveheurefromEvenements < ActiveRecord::Migration
  def self.up

	remove_column :evenements, :heure_evenmt

  end
end
