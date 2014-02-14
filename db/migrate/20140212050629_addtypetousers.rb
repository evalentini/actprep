class Addtypetousers < ActiveRecord::Migration
  def change
    add_column :users, :usertype, :string, default: "student"
  end
end
