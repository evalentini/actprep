class UsersController < ApplicationController
  
  def modify
    @users=User.all
    @new_user_pwd = User.rand_pwd
  end
  
  def save
    User.make_with_pwd(params[:email], params[:username], params[:password], params[:role])
    respond_to do |format|
      format.json {render :json => User.find_by_email(params[:email])}
    end
  end
  
  def delete
    User.find(params[:id]).destroy
    respond_to do |format|
      format.json {render :json => User.find(1)}
    end 
  end
  
end 