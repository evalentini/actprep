class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :confirm_login


	private

	  def current_user 
	  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end

	  
	  def confirm_login
	    unless session[:password].present?
	 	  redirect_to login_path
		else
		  redirect_to login_path unless User.find(session[:user_id]).check_pwd(session[:password]) == true
		end
	end

end







