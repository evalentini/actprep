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
  		else
        flash.now[:failure] = "Wrong Username or Password"  
        render 'new'
      end
    else
      if @user = params[:username]
      flash.now[:failure] = "Wrong Username or Password"  
      render 'new'
      end
  	end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end 

  


end
