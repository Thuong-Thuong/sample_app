class Dropcolumnfromapprobations < ActiveRecord::Migration
  def change
	remove_column :approbations, :approuve
  end
end
