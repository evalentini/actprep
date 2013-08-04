class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :test_number
      t.string :section
      t.integer :question_number
      t.text :question_text
      t.integer :num_ans_choices
      t.integer :correct_ans

      t.timestamps
    end
  end
end
