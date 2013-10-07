class UsersController < ApplicationController
  
  def editUser
    argHash={'email'=>params[:email], 'username'=>params['username'], 'role'=>params['role'], 'pwd'=>params['pwd']}
    User.find(params['id'].to_i).editWithPwd(argHash)
    respond_to do |format|
      format.json {render :json => User.find(params['id'])}
    end 
  end
  
  def temppass
    id=params[:user_id]
    respond_to do |format|
     jsonstring = '{"pwd":"'+User.rand_pwd+'"}'
     format.json {render :json => jsonstring }
     
    end
  end
  
  def modify
    @users=User.select("*").order("username")
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