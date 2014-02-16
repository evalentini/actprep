class Tasks < ActiveRecord::Base
  
  attr_accessible :homework_id, :student_id
  validates_uniqueness_of :homework_id, :scope => :student_id
  
   belongs_to :homework
  
   before_save :checkquiz
   
   def checkquiz
     raise "quizzes cannot be assigned to students" if self.homework.quiz==true
   end
   
   
  
end
