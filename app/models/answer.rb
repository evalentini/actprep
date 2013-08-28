class Answer < ActiveRecord::Base
  attr_accessible :question_id, :selected_ans, :user_id
  validates_presence_of :question_id

  belongs_to :question 
  belongs_to :user


  #def self.record(question, user, ans_choice)
	#Answer.create(question_id: question.id, user: user.id, ans_choice: ans_choice)
  #end
end
