class Question < ActiveRecord::Base
  attr_accessible :correct_ans, :num_ans_choices, :question_number, :section, :test_number,
  :ans_choice_1, :ans_choice_2, :ans_choice_3, :ans_choice_4, :ans_choice_5,
  :user_id, :page
  belongs_to :user
end
