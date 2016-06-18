class RemovecommentpereIdFromCommentaires < ActiveRecord::Migration
  def self.up
	remove_column :commentaires, :commentpere_id
  end
end
