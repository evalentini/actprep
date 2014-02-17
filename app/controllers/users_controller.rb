class UsersController < ApplicationController
    skip_before_filter :authorization, except: [:modify]
  


  def editUser
    
    argHash={'email'=>params[:email], 'username'=>params['username'], 'role'=>params['role'], 'pwd'=>params['pwd']}

    #if user is not editable we want to skip any edits
    User.find(params['id'].to_i).editWithPwd(argHash) unless User.find(params['id'].to_i).locked==true
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
    @users=User.select("*").order("role, email")
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
  
  def profile 
     @user = User.find(session[:user_id])
     @user.update_attributes(params[:user]) unless params[:user].nil? 
     @tutorrequests=Friendship.where("tutor_id=#{@user.id} and (pending=true or approved=true)")
     @studentrequests=Friendship.where("student_id=#{@user.id}")
  end
  
  def friendrequest
    unless params[:email].nil?
      @student=User.where(email: params[:email]).first
      unless @student.nil?
        @tutor=User.find(session[:user_id])
        @friendship=Friendship.new({tutor_id: @tutor.id, student_id: @student.id, pending: true, approved: false})
        @friendship.save
      end
    end
    respond_to do |format|
      format.json { head :no_content}
    end  
  end
  
  def approve
    Friendship.update_all("approved=true, pending=false", 
                          "tutor_id=#{params[:id]} and student_id=#{session[:user_id]}")
                          redirect_to action: "profile"
  end
  
  def unfriend
    Friendship.delete_all("student_id=#{session[:user_id]} and tutor_id=#{params[:id]}")
    redirect_to action: "profile"
  end
  
end 