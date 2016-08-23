class Changecolumnfrommessages < ActiveRecord::Migration
  def change
      t.change :i_sup, 'integer USING CAST(i_sup AS integer)',
 :default => 0
	 t.change :i_sup_rec, 'integer USING CAST(i_sup_rec AS integer)', :default => 0
    end
  end
end
