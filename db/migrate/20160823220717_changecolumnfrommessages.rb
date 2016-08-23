class Changecolumnfrommessages < ActiveRecord::Migration
  def change
	change_table :messages do |t|
      t.change :i_sup, :integer, :default => 0
	 t.change :i_sup_rec, :integer, :default => 0

    end

  end
end
