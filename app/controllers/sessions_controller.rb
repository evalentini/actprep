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
        flash.now[:danger] = "Wrong Password"  
        render 'new'
      end
    else
      if @email = params[:email]
      flash.now[:danger] = "Email Not Found"  
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
  
  def signup
  end
  
  def signupsave
    User.make_with_pwd(params[:email], params[:firstname]+"-"+params[:lastname], params[:password], "student")
    @user=User.find_by_email(params[:email])
    @user.update_attributes(:firstname => params[:firstname], 
                            :lastname => params[:lastname],
                            :usertype => params[:usertype])
    flash.now[:danger] = "Welcome #{params[:firstname]} #{params[:lastname]}!"
    session[:user_id] = @user.id
    session[:password] = params[:password]
    redirect_to controller: "users", action: "profile"
  end

  


end
