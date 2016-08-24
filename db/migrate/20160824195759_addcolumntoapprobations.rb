class Addcolumntoapprobations < ActiveRecord::Migration
  def change
	add_column :approbations, :approuve, :integer
  end
end
