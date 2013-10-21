class AnswersController < ApplicationController
  skip_before_filter :authorization, except: [:dashboard]


  def dashboard
  end
  
  def save
    user = User.find(session[:user_id])
    Answer.create(question_id: params[:question_id], user_id: user.id, selected_ans: params[:ans_choice])
    redirect_to action: "home", controller: "pages"
  end
  
  def record

    if params[:id].present?
      @question = Question.find(params[:id]) 
    else 
      @question = Question.where(test_number: params[:test_number], 
                                 section: params[:section], 
                                 question_number: params[:question]
                                ).first
    end
    
    # TODO DRY this:
    sections = ['english', 'math', 'reading', 'science']
    default_section = 'english'
    @default_section_pageimage = "#{default_section}_pg1.jpg"
    @default_section_maxpage=Question.maxpage(1, default_section).to_i
    @maxpage_hash = {}
    sections.each {|sec| @maxpage_hash[sec]=Question.maxpage(1,sec).to_i }
    @maxpage_hash['science']=Question.maxpage(1, "science").to_i
    @questions = Question.order("test_number, section, question_number")
    @maxtest = Question.maximum("test_number") || 0
    
    @maxquestion = {}
    sections.each do |section|
      @maxquestion[section] = Question.where(test_number: 1, section: section).maximum("question_number") || 0
    end       
    @filename = "#{@question.section}_pg#{@question.page}.jpg"


    @user = User.find(session[:user_id])
  
    # @ans_choice = params[:ans_choice_radio]
    
 
   # Answer.create(question_id: question.id, user_id: user.id, selected_ans: ans_choice)
  
  end

  def submit
    answer = Answer.new
    answer.question_id = params[:q_id]
    answer.user_id = session[:user_id]
    answer.selected_ans = params[:ans]
    
    answer.save
    @answer = answer
  end


  def show
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
  end

end
