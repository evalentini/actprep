class PagesController < ApplicationController
  def home
  	@active = "summary"
  	user = User.find_by_id(session[:user_id])

  	@questions = user.questions


  end
end


# class User < ActiveRecord::Base
#   has_many :microposts, dependent: :destroy

# class Micropost < ActiveRecord::Base
#   belongs_to :user