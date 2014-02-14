class Homework < ActiveRecord::Base
  has_many :questions
  has_many :tasks
  belongs_to :user
  attr_accessible :due, :name, :user_id
  
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
  
  def assignedStudents
    studentids="-999"
    Tasks.where(homework_id: self.id).each do |task|
        studentids+=", #{task.student_id}"
    end
    User.where("id IN (#{studentids})").order("email asc")
  end
  
  
  
end
