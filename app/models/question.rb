class Question < ActiveRecord::Base
  
  
  
  attr_accessible :correct_ans, :num_ans_choices, :question_number, :section, :test_number,
  :ans_choice_1, :user_id, :page
  
  belongs_to :user
  
  validates_presence_of :question_number
  validates_presence_of :page
  validates_presence_of :correct_ans
  validates_presence_of :ans_choice_1
  validates_presence_of :num_ans_choices
  
  def rightChoice
    (self.ans_choice_1..'Z').to_a[0, self.num_ans_choices][self.correct_ans-1]
  end
  
  def choiceList
    ((self.ans_choice_1..'Z').to_a[0, self.num_ans_choices]).join(" ")
  end
  
  def correctAnswerOptions
    (self.ans_choice_1..'Z').to_a[0, self.num_ans_choices]
  end
  
  def maxpage
    testnumber=self.test_number
    section=self.section
    Question.maxpage(testnumber, section)
  end
  
  def self.maxpage(testnumber, section)
    maxpage={}
    maxpage_list={}
    maxpage_list[1]={}
    maxpage_list[1]["math"]=16
    maxpage_list[1]["science"]=14
    maxpage_list[1]["english"]=12
    maxpage_list[1]["reading"]=8
    
    logger.info "---model test is #{testnumber} and section is #{section}--"
    
    return maxpage_list[testnumber.to_i][section]
    
  end
  
  
end
