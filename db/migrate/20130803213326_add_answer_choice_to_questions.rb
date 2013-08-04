class AddAnswerChoiceToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :ans_choice_1, :text
  	add_column :questions, :ans_choice_2, :text
  	add_column :questions, :ans_choice_3, :text
  	add_column :questions, :ans_choice_4, :text
  	add_column :questions, :ans_choice_5, :text
  end
end
