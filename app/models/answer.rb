class Answer < ActiveRecord::Base
  attr_accessible :question_id, :selected_ans, :user_id, :timetaken 
  validates_presence_of :question_id
  validates_presence_of :selected_ans

  belongs_to :question 
  belongs_to :user
  
  
  def correct
    if self.selected_ans==self.question.correct_ans 
      true 
    else 
      false
    end 
  end
  
  def timeTakenString
    result="--"
    unless self.timetaken.nil?
      result=(self.timetaken.to_f/60).floor.to_s
      result=result+":"+(self.timetaken-(60*(self.timetaken.to_f/60).floor)).to_s 
    end
    result
  end
  
  def self.answeredQuestions(user_id) 
    
  end 

  #def self.record(question, user, ans_choice)
	#Answer.create(question_id: question.id, user: user.id, ans_choice: ans_choice)
  #end
end
