class Modifycolumnfrommessages < ActiveRecord::Migration
  def change
	change_table :messages do |t|
      t.change :i_sup, 'integer USING CAST(i_sup AS integer)',
 :default => 0
	 t.change :i_sup_rec, 'integer USING CAST(i_sup_rec AS integer)', :default => 0
    end
  end
end
