class Addusertohomework < ActiveRecord::Migration
  def change
    add_column :homeworks, :user_id, :integer
  end
end
