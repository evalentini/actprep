class SessionsController < ApplicationController
  
skip_before_filter :confirm_login
skip_before_filter :authorization


  def new
  	@active = "login"
  	params[:email].present? ? @email = params[:email] : @email = ''
  	@email_record = User.find_by_email(@email) if User.find_by_email(@email)
  	if User.find_by_email(@email)
  		session[:user_id] = User.find_by_email(@email).id
  		session[:password] = params[:password]
  		if @email_record.check_pwd(params[:password])
  			redirect_to root_path
  		else
        flash.now[:failure] = "Wrong Password"  
        render 'new'
      end
    else
      if @email = params[:email]
      flash.now[:failure] = "Wrong Email"  
      render 'new'
      end
  	end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end 
  
  def createFacebook
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  


end
