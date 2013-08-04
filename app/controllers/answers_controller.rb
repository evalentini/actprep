class AnswersController < ApplicationController
  def record

  	question = Question.where(test_number: params[:test_number], 
  					section: params[:section],
  					question_number: params[:question_number]).first

  	user = User.find(session[:user_id])
  	

  	ans_choice = params[:ans_choice_radio]
  	
 
   Answer.create(question_id: question.id, user_id: user.id, selected_ans: ans_choice)
  
  end
end
