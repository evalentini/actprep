class Question < ActiveRecord::Base
  
  
  
  attr_accessible :correct_ans, :num_ans_choices, :question_number, :section, :test_number,
  :ans_choice_1, :user_id, :page
  
  belongs_to :user
  
  validates_presence_of :question_number
  validates_presence_of :page
  validates_presence_of :correct_ans
  validates_presence_of :ans_choice_1
  
end
