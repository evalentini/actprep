class Homework < ActiveRecord::Base
  has_many :questions
  has_many :tasks
  has_many :quizscores
  belongs_to :user
  attr_accessible :due, :name, :user_id, :quiz, :finishedquiz
  
  before_save :quizlogic
  
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
  
  def quizlogic
    self.quiz ||=false
    #quizzes are universal, not assigned by a tutor to students so they should not have creator 
    self.user_id=nil if self.quiz==true
  end
  
  
  def saveQuiz(user_id)
    numq=0
    numr=0
    cumtime=0
    targettime=0
    completetime=self.questions.first.updated_at
    self.questions.each do |question|
      numq+=1
      answer=question.answers.where(user_id:user_id).first
      numr+=1 if answer.correct
      cumtime+=answer.timetaken
      targettime+=question.targetTime
      completetime=[completetime, question.updated_at].max
    end
    if Quizscore.where(homework_id: self.id, student_id: user_id).count==0
      qscore=Quizscore.new({:completed=>completetime, :cum_time=>cumtime, 
                          :homework_id=>self.id, :num_question=>numq, 
                          :num_right=>numr, :student_id=>user_id})
      qscore.save
    else
     quiz=Quizscore.where(homework_id: self.id, student_id: user_id).first
     quiz.update_attributes({:completed=>completetime, 
                          :cum_time=>cumtime, 
                         :homework_id=>self.id, :num_question=>numq, 
                          :num_right=>numr, :student_id=>user_id})
    end
  end
  
  def checkComplete(user_id)
    if self.quizscores.where(student_id: user_id).count>0
      return true
    else
      return false
    end
  end
  
end
