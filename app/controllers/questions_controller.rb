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
    @maxtest = Question.maximum("test_number")
    @maxquestion = 0 || Question.where(test_number: 1, section: 'math').maximum("question_number")
  end 
  
  def add
    Question.create(correct_ans: params[:correct_answer], num_ans_choices: 4, question_number: params[:question_number] ,section: params[:section], 
    test_number: params[:test], ans_choice_1: params[:choice1], ans_choice_2: params[:choice2], ans_choice_3: params[:choice3],
    ans_choice_4: params[:choice4])
    
    respond_to do |format|
      format.json {render :json => Question.all}
    end
    
  end
  

end



