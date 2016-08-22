class Modifycolumnfromsignalements < ActiveRecord::Migration
  def change
	change_table :signalements do |t|
      t.change :validation, :boolean, :default => false
    end
  end
end
