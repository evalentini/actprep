class PagesController < ApplicationController
  skip_before_filter :authorization

  def formattest
  end
  
  def quiz
    @quizzes=Homework.where(quiz: true)
    @user=User.find(session[:user_id])
  end
  
  def assignhomework
    @user=User.find(session[:user_id])
    if Homework.find(params[:homeworkid]).user.id==@user.id && @user.checkfriend(params[:studentid])==true
      @task=Tasks.new({:student_id => params[:studentid], :homework_id => params[:homeworkid]})
      @task.save
    end
    redirect_to action: "studentassignment", id: params[:homeworkid]
  end
  
  def unassignhomework
    @user=User.find(session[:user_id])
    if Homework.find(params[:homeworkid]).user.id==@user.id && @user.checkfriend(params[:studentid])==true
      Tasks.delete_all("homework_id=#{params[:homeworkid]} and student_id=#{params[:studentid]}")
    end
    redirect_to action: "studentassignment", id: params[:homeworkid]
  end
  
  def studentassignment 
    @homework=Homework.find(params[:id])
    @user=User.find(session[:user_id])
    @numFriends=Friendship.where(tutor_id: @user.id, approved: true).count
  end
  
  def homework
    @currentuser = User.find_by_id(session[:user_id]) 
    @user=@currentuser
    @viewingstudenthomework=false
    if @currentuser.usertype=="tutor" && params[:id].present?
      if @currentuser.checkfriend(params[:id])==true
        @user=User.find(params[:id]) 
        @viewingstudenthomework=true
      end
    end
    @homeworks=Homework.order("due asc")
  end
  
  def tutorhomework
  end

  def home
    @isquizresult = true
    
    @sectionfilter = (params[:sectionfilter].nil?  && "all") || params[:sectionfilter]
    @correctfilter = (params[:correctfilter].nil?  && "all") || params[:correctfilter]
    @speedfilter = (params[:speedfilter].nil?  && "all") || params[:speedfilter]
    @quizfilter = (params[:quizid].nil?  && "all") || params[:quizid]
    
    @isquizresult = false if @quizfilter=="all"
    
    unless @isquizresult==false
      unless params[:noupdate].present?
        #save quiz results
        Homework.find(params[:quizid]).saveQuiz(session[:user_id])
      end
    end
    
    @sectionfilter = "all" if @sectionfilter.nil?
    @correctfilter = "all" if @correctfilter.nil?
    @speedfilter = "all" if @speedfilter.nil?
    @quizfilter = "all" if @quizfilter.nil?
    
    @filter_hash= {:section => @sectionfilter, :correct=>@correctfilter, :speed=>@speedfilter, :quiz=>@quizfilter}
    
    user=User.find_by_id(session[:user_id])
    @user = User.find_by_id(session[:user_id])
    @questions=Question.order("test_number asc, section, question_number asc")
  end
  
  def admin
    @active="admin"
  end 
  
  def statistics
  	user = User.find_by_id(session[:user_id])
    @user = User.find_by_id(session[:user_id])
    
    if user.answers.count>0 
      @summary = user.answerSummary
      @numCorrect = @summary[:correct].length
      @numIncorrect = @summary[:incorrect].length
      @notAttempted = @summary[:not_attempted].length
      @totalNum = Question.count(:id).to_f
      
      @currentLevel="NEWBIE"
      @currentLevel="INTERMEDIATE" if @numCorrect.to_f/@totalNum.to_f > 0.5
      @currentLevel="PRO" if @numCorrect.to_f/@totalNum.to_f > 0.8
      @currentLevel="TOTAL MASTER" if @numCorrect.to_f/@totalNum.to_f >= 1.0      
 
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Question')
      data_table.new_column('number', 'Result')
      data_table.add_rows(3)
      data_table.set_cell(0, 0, 'Correct'     )
      data_table.set_cell(0, 1, @numCorrect )
      data_table.set_cell(1, 0, 'Incorrect'      )
      data_table.set_cell(1, 1, @numIncorrect  )
      data_table.set_cell(2, 0, 'Not Answered'  )
      data_table.set_cell(2, 1, @notAttempted )

     
      opts   = { :width => 800, :height => 600, :title => '', :is3D => true, slices: [{color: 'green'},{color: 'red'},{color: 'yellow', textStyle: {color: 'black'}}]}
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

    end 
    
  end
  
end


# class User < ActiveRecord::Base
#   has_many :microposts, dependent: :destroy

# class Micropost < ActiveRecord::Base
#   belongs_to :user