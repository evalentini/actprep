class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :confirm_gate
  before_filter :confirm_login
  before_filter :authorization


	private

	  def current_user 
	  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
	  end
    
    def confirm_gate
      if session[:accesscode].present? 
        unless session[:accesscode].nil?
          if Digest::SHA2.hexdigest(session[:accesscode])=="5d2a0db78c45a6788200fb007fcbd9513dc1f418e62bb8e7ac5c70d17f000e68"
          else
            redirect_to gate_path 
          end
        else
          redirect_to gate_path
        end
      else
        redirect_to gate_path
      end
    end

	  
	  def confirm_login
	    unless session[:user_id].present?
	 	    redirect_to login_path
		  else
        if User.find(session[:user_id]).omniauth_user==true
          @user_email = User.find(session[:user_id]).email
          User.find(session[:user_id]).role=="admin" ? @is_admin=true : @is_admin=false
        else
          unless session[:password].present?
            redirect_to login_path
          else
            if User.find(session[:user_id]).check_pwd(session[:password]) == true 
              @user_email = User.find(session[:user_id]).email
              User.find(session[:user_id]).role=="admin" ? @is_admin=true : @is_admin=false
              User.find(session[:user_id]).usertype=="tutor" ? @is_tutor=true : @is_tutor=false
            else 
              redirect_to login_path
            end
          end
        end 
		  end
	  end

  
   protected
   def authorization
     redirect_to(root_url) unless current_user.role == 'admin'
   end

end







