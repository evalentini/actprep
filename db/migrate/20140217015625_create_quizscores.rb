class CreateQuizscores < ActiveRecord::Migration
  def change
    create_table :quizscores do |t|
      t.integer :homework_id
      t.integer :student_id
      t.datetime :completed
      t.integer :num_question
      t.integer :num_right
      t.float :cum_time

      t.timestamps
    end
  end
end
