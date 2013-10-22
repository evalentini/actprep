class PagesController < ApplicationController
  skip_before_filter :authorization


  def home
  	@active = "summary"
  	user = User.find_by_id(session[:user_id])
    
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
      
      logger.info "-----RATIO #{@numCorrect/@totalNum}-----"
      
 
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Question')
      data_table.new_column('number', 'Result')
      data_table.add_rows(3)
      data_table.set_cell(0, 0, 'Number Correct'     )
      data_table.set_cell(0, 1, @numCorrect )
      data_table.set_cell(1, 0, 'Number Incorrect'      )
      data_table.set_cell(1, 1, @numIncorrect  )
      data_table.set_cell(2, 0, 'Not Answered'  )
      data_table.set_cell(2, 1, @notAttempted )

     
      opts   = { :width => 800, :height => 600, :title => 'Results', :is3D => true, slices: [{color: 'green'},{color: 'red'},{color: 'yellow', textStyle: {color: 'black'}}]}
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, opts)

    end 
    #@answers = user.answers
    #@questions = user.answers.select("question_id").group("question_id")
  end
  
  def admin
    @active="admin"
  end 
  
end


# class User < ActiveRecord::Base
#   has_many :microposts, dependent: :destroy

# class Micropost < ActiveRecord::Base
#   belongs_to :user