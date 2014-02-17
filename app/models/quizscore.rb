class Quizscore < ActiveRecord::Base
  attr_accessible :completed, :cum_time, :homework_id, :num_question, :num_right, :student_id
  
  belongs_to :homework 
  belongs_to :user
  
end
