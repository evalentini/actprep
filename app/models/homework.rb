class Homework < ActiveRecord::Base
  has_many :questions
  attr_accessible :due, :name
  
  def addQuestion(test_number, section, question_number)
    qid=Question.where(test_number: test_number, section: section, question_number: question_number).first.id
    Question.update(qid, :homework_id => self.id)
  end
  
  def self.removeQuestion(qid)
    Question.update(qid, :homework_id => nil)
  end
  
  def pctCompleted(uid)
    numq=self.questions.count
    numansweredq=0
    self.questions.each do |question|
      numansweredq+=1 if question.isAnswered(uid)==true
    end
    
    result = 100
    result = ((numansweredq.to_f/numq.to_f)*100).to_i if numq>0
    
    return result
    
  end
  
end
