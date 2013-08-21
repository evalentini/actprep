class AnswersController < ApplicationController
  def record

    question = Question.where(test_number: params[:test_number], 
            section: params[:section],
            question_number: params[:question_number]).first

    user = User.find(session[:user_id])
    

    ans_choice = params[:ans_choice_radio]
    
 
   Answer.create(question_id: question.id, user_id: user.id, selected_ans: ans_choice)
  
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
