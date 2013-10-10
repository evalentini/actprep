class AnswersController < ApplicationController
  
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
            
    @filename = "#{@question.section}_pg#{@question.page}.jpg"


    @user = User.find(session[:user_id])
    
    @cutoffs = {}
    @cutoffs[:english]={}
    @cutoffs[:english][:yellow]=50 
    @cutoffs[:english][:red]=120
    @cutoffs[:math]={}
    @cutoffs[:math][:yellow]=40

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
