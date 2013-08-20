class SessionsController < ApplicationController
  
skip_before_filter :confirm_login



  def new
  	@active = "login"
  	params[:username].present? ? @user = params[:username] : @user = ''
  	@user_record = User.find_by_username(@user) if User.find_by_username(@user)
  	if User.find_by_username(@user)
  		session[:user_id] = User.find_by_username(@user).id
  		session[:password] = params[:password]
  		if @user_record.check_pwd(params[:password])
  			redirect_to root_path
  		end	
  	end
  end

  


end
