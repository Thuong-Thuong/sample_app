class Droptablemessagesagain < ActiveRecord::Migration
  def change
	drop_table :messages

  end
end
