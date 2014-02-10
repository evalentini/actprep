class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :name
      t.datetime :due

      t.timestamps
    end
  end
end
