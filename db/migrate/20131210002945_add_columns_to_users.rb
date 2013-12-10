class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_user, :boolean
    add_column :users, :provider, :string
    add_column :users, :uid, :integer
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
  end
end
