class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, default: "none"
    add_column :users, :lastname, :string, default: "none"
  end
end
