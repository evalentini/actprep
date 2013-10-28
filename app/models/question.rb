class Question < ActiveRecord::Base
  
  
  
  attr_accessible :correct_ans, :num_ans_choices, :question_number, :section, :test_number,
  :ans_choice_1, :user_id, :page, :explanation, :explanation_image, :explanation_image_file_name
  
  belongs_to :user
  has_many :answers
  
  has_attached_file :explanation_image
  
  validates_presence_of :question_number
  validates_presence_of :page
  validates_presence_of :correct_ans
  validates_presence_of :ans_choice_1
  validates_presence_of :num_ans_choices
  validates_uniqueness_of :question_number, scope: [:section, :test_number]
  
  def maxpage
    Question.maxpage(self.test_number, self.section)
  end
  def rightChoice

    alphaArray = Actprep::Application.alphabetArray
    alphaHash = Actprep::Application.alphabetHash
    
    alphaArray[alphaHash[self.ans_choice_1], self.num_ans_choices][self.correct_ans-1]
    
    #(self.ans_choice_1..'Z').to_a[0, self.num_ans_choices][self.correct_ans-1]
  end
  
  def choiceList

    alphaArray = Actprep::Application.alphabetArray
    alphaHash = Actprep::Application.alphabetHash

    alphaArray[alphaHash[self.ans_choice_1], self.num_ans_choices].join(" ")  
    #((self.ans_choice_1..'Z').to_a[0, self.num_ans_choices]).join(" ")
  end
  
  def correctAnswerOptions

    alphaArray = Actprep::Application.alphabetArray
    alphaHash = Actprep::Application.alphabetHash

    alphaArray[alphaHash[self.ans_choice_1], self.num_ans_choices]  
    
    #(self.ans_choice_1..'Z').to_a[0, self.num_ans_choices]
  end
  
  def ansChoiceLetter(num)

    alphaArray = Actprep::Application.alphabetArray
    alphaHash = Actprep::Application.alphabetHash

    alphaArray[alphaHash[self.ans_choice_1], self.num_ans_choices][num.to_i-1]  


#    (self.ans_choice_1..'Z').to_a[0, self.num_ans_choices][num.to_i-1]
  end
  
  def ansChoiceNumber(letter)
    self.choiceList.rindex(letter)/2+1
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
        
    return maxpage_list[testnumber.to_i][section]
    
  end
  
  
end
