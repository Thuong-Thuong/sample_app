class RemoverecipientIdfromconversations < ActiveRecord::Migration
  def self.up
    remove_column :conversations, :recipient_id
  end
end
