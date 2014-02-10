class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :name
      t.string :due
      t.string :date

      t.timestamps
    end
  end
end
