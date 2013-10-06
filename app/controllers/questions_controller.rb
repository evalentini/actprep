class QuestionsController < ApplicationController
  

  def maxpage
    
    maxpage_item={}
    maxpage_item["current"]=Question.maxpage(params['test'],params['section'])
    
    
    respond_to do |format|
      format.json { render :json => maxpage_item}
    end
    
  end
  
  def answer
    @has_question = false
    @tests = Question.select("test_number").group(:test_number)
    @sections = Question.select("section").group(:section)
    
    @default_q = Question.first
    @num_questions = Question.where(test_number: @default_q.test_number, section: @default_q.section).count("id")
    
    if params[:section]
      #all this shit
      @question = Question.where(test_number: params[:test_number], 
            section: params[:section],
            question_number: params[:question_number]).first
      @has_question = true if @question
      @ans_choices = []
      (1..@question.num_ans_choices).each do |i|
        @ans_choices << @question.send("ans_choice_"+i.to_s)
      end
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def page_image
    @filename = "science page 3.jpg"
  end
  
  def modify

    sections = ['math', 'english', 'science', 'reading']
    default_section = 'math'
    @default_section_maxpage=Question.maxpage(1, default_section).to_i
    @questions = Question.all
    @maxtest = Question.maximum("test_number") || 0
    
    @maxpage
    @maxquestion = {}
    sections.each do |section|
      @maxquestion[section] = Question.where(test_number: 1, section: section).maximum("question_number") || 0
    end 
  end 
  
  def add
    Question.create(correct_ans: params[:correct_answer], num_ans_choices: 4, question_number: params[:question_number] ,section: params[:section], 
    test_number: params[:test], ans_choice_1: params[:choice1], page: params[:page])
    
    respond_to do |format|
      format.json {render :json => Question.all}
    end
    
  end
  
  def list 
    respond_to do |format|
      format.json {render :json => Question.where(test_number: params[:test], section: params[:section])}
    end 
  end 
  
  def viewimage
    @filename = "#{params[:section]}_pg#{params[:page]}.jpg"
    section=params[:section]
    page = params[:page].to_i
    prev_page = page-1
    next_page = page+1
    @prev_link = "/questions/viewimage/#{section}/#{prev_page}"
    @next_link = "/questions/viewimage/#{section}/#{next_page}"
    
  end
  
  

end



