class Addhomeworktoquestions < ActiveRecord::Migration
  def change
    add_column :questions, :homework_id, :integer
  end
end
