class AddTimeTakenToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :timetaken, :integer
  end
end
