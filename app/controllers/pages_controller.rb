class PagesController < ApplicationController
  skip_before_filter :authorization


  def home
  	@active = "summary"
  	user = User.find_by_id(session[:user_id])
    
    if user.answers.count>0 
      @summary = user.answerSummary
      @numCorrect = @summary[:correct].length
      @numIncorrect = @summary[:incorrect].length
      @notAttempted = @summary[:not_attempted].length
      @totalNum = Question.count(:id).to_f
      
      @currentLevel="NEWBIE"
      @currentLevel="INTERMEDIATE" if @numCorrect.to_f/@totalNum.to_f > 0.5
      @currentLevel="PRO" if @numCorrect.to_f/@totalNum.to_f > 0.8
      @currentLevel="TOTAL MASTER" if @numCorrect.to_f/@totalNum.to_f >= 1.0
      
      logger.info "-----RATIO #{@numCorrect/@totalNum}-----"
      
      
      
      
      
    end 
    #@answers = user.answers
    #@questions = user.answers.select("question_id").group("question_id")
  end
  
  def admin
    @active="admin"
  end 
  
end


# class User < ActiveRecord::Base
#   has_many :microposts, dependent: :destroy

# class Micropost < ActiveRecord::Base
#   belongs_to :user