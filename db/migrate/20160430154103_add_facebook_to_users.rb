class AddFacebookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fprovider, :string
    add_column :users, :fuid, :string
    add_column :users, :foauth_token, :string
    add_column :users, :foauth_expires_at, :datetime
  end
end
