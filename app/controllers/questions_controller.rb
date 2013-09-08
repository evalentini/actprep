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
  end 

end
