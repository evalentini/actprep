class Question < ActiveRecord::Base
  
  
  
  attr_accessible :correct_ans, :num_ans_choices, :question_number, :section, :test_number,
  :ans_choice_1, :user_id, :page, :explanation, :explanation_image, :explanation_image_file_name, :homework_id
  
  belongs_to :user
  belongs_to :homework
  has_many :answers
  
  has_attached_file :explanation_image
  
  validates_presence_of :question_number
  validates_presence_of :page
  validates_presence_of :correct_ans
  validates_presence_of :ans_choice_1
  validates_presence_of :num_ans_choices
  validates_uniqueness_of :question_number, scope: [:section, :test_number]
  
  def shortDescription
    self.test_number.to_s+"MC-"+self.section.titlecase+"-"+self.question_number.to_s
  end
  
  def btnType(uid)
    btnType="btn-default"
    btnType="btn-success" if self.isCorrect(uid)==true
    btnType="btn-danger" if self.isCorrect(uid)==false && self.isAnswered(uid)==true
    btnType
  end
  
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
  
  def self.testList
    list={}
    Question.select("test_number").group(:test_number).each do |test|
      list[test.test_number.to_s+"MC"]=test.test_number
    end
    
    list
    
  end
  
  def self.defQ
    Question.first
  end
  
  def self.sectionList
    list={}
    Question.select("section").group(:section).order(:section).each do |section|
      list[section.section.titlecase]=section.section
    end
    
    list
    
  end
  
  def self.sectionListWithAll
    list={}
    list["All"]="all"
    list.merge!(Question.sectionList)
    
    list
    
  end
  
  def self.questionList(test_number=1, section="english")
    maxq=Question.where(test_number: test_number, section: section).count("id")
    list={}
    (1..maxq).each do |i|
      list[i]=i
    end
    
    list
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
  
  def answerTime(uid)
    if isAnswered(uid)==true
      Answer.where(question_id: self.id, user_id:uid).order("created_at desc").limit(1).first.timeTakenString
    else
      "n/a"
    end
  end
  
  def fastAnswer(uid)
    cutoffs={}
    cutoffs["english"]=40
    cutoffs["math"]=60
    cutoffs["reading"]=52
    cutoffs["science"]=52
    
    if (Answer.where(user_id: uid, question_id: self.id).count>0)
      time=Answer.where(question_id: self.id, user_id:uid).order("created_at desc").limit(1).first.timetaken
      if (time<=cutoffs[self.section])
        true
      else
        false
      end
    else
      true
    end
    
  end
  
  def isAnswered(uid)
    if (Answer.where(user_id: uid, question_id: self.id).count>0)
      true
    else
      false
    end
  end
  
  def isCorrect(uid)
    if (self.isAnswered(uid)==true)
      mr_answer=Answer.where(question_id: self.id, user_id:uid).order("created_at desc").limit(1).first
      if (mr_answer.selected_ans==self.correct_ans) 
        true
      else
        false
      end
    else
      false
    end
  end
  
  def correctnessStatus(uid)
    status="na"
    status="correct" if self.isCorrect(uid)==true
    status="incorrect" if self.isCorrect(uid)==false && self.isAnswered(uid)==true
    status
  end
  
  def speedStatus(uid)
    status="na"
    status="fast" if self.fastAnswer(uid)==true  && self.isAnswered(uid)==true
    status="slow" if self.fastAnswer(uid)==false && self.isAnswered(uid)==true
    status
  end
  
  def satisfyFilters(uid, filter_hash)
    result=true
    #section filter 
    unless filter_hash[:section]=="all"
      result=false unless self.section==filter_hash[:section]
    end
    #correctness filter
    unless filter_hash[:correct]=="all"
      result=false unless self.correctnessStatus(uid)==filter_hash[:correct]
    end
    #speed filter
    unless filter_hash[:speed]=="all" || filter_hash[:correct]=="na" #dont check speed if question was not attempted
      result=false unless self.speedStatus(uid)==filter_hash[:speed]
    end
    
    result
  end
  
  
end
