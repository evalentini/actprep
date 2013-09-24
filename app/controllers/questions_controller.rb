class QuestionsController < ApplicationController
  def answer
    @has_question = false
    @tests = Question.select("test_number").group(:test_number)
    @sections = Question.select("section").group(:section)
    
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
    @questions = Question.all
    @maxtest = Question.maximum("test_number") || 0
    sections = ['math', 'english', 'science', 'reading']
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
  end
  
  

end



