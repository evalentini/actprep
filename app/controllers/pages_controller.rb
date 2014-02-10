class PagesController < ApplicationController
  skip_before_filter :authorization

  def formattest
  end
  
  def homework
  end

  def home
    @sectionfilter = (params.nil?  && "all") || params[:sectionfilter]
    @correctfilter = (params.nil?  && "all") || params[:correctfilter]
    @speedfilter = (params.nil?  && "all") || params[:speedfilter]
    
    @sectionfilter = "all" if @sectionfilter.nil?
    @correctfilter = "all" if @correctfilter.nil?
    @speedfilter = "all" if @speedfilter.nil?
    
    @filter_hash= {:section => @sectionfilter, :correct=>@correctfilter, :speed=>@speedfilter}
    
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