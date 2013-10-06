class PagesController < ApplicationController
  
  def home
  	@active = "summary"
  	user = User.find_by_id(session[:user_id])
    
    if user.answers.count>0 
      @summary = user.answerSummary
      @pctAnswered = user.pctAnswered
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