class AnswersController < ApplicationController
  skip_before_filter :authorization, except: [:dashboard]


  def dashboard
  @questions = Question.count
  @questions_with_explanations = Question.count(:explanation)
  @english_questions = Question.where(section: "english").count
  @english_questions_with_explanations = Question.where(section: "english").count(:explanation)
  @reading_questions = Question.where(section: "reading").count
  @reading_questions_with_explanations = Question.where(section: "reading").count(:explanation)
  @science_questions = Question.where(section: "science").count
  @science_questions_with_explanations = Question.where(section: "science").count(:explanation)
  @math_questions = Question.where(section: "math").count
  @math_questions_with_explanations = Question.where(section: "math").count(:explanation)

  data_table = GoogleVisualr::DataTable.new
  data_table.new_column('string', 'Section')
  data_table.new_column('number', 'Number of questions')
  data_table.new_column('number', 'Number of questions with explanations')
  data_table.add_rows(5)
  data_table.set_cell(0, 0, 'All')
  data_table.set_cell(0, 1, @questions)
  data_table.set_cell(0, 2, @questions_with_explanations)
  data_table.set_cell(1, 0, 'English')
  data_table.set_cell(1, 1, @english_questions)
  data_table.set_cell(1, 2, @english_questions_with_explanations)
  data_table.set_cell(2, 0, 'Reading')
  data_table.set_cell(2, 1, @reading_questions)
  data_table.set_cell(2, 2, @reading_questions_with_explanations)
  data_table.set_cell(3, 0, 'Science')
  data_table.set_cell(3, 1, @science_questions)
  data_table.set_cell(3, 2, @science_questions_with_explanations)
  data_table.set_cell(4, 0, 'Math')
  data_table.set_cell(4, 1, @math_questions)
  data_table.set_cell(4, 2, @math_questions_with_explanations)

 
  opts   = { :width => 800, :height => 500, :title => 'Number of Questions per section', vAxis: {title: 'Section', titleTextStyle: {color: 'red'}} }
  @chart = GoogleVisualr::Interactive::BarChart.new(data_table, opts)

  end
  
  def save
    user = User.find(session[:user_id])
    Answer.create(question_id: params[:question_id], user_id: user.id, selected_ans: params[:ans_choice])
    redirect_to action: "home", controller: "pages"
  end
  
  def record

    if params[:id].present?
      @question = Question.find(params[:id]) 
    else 
      @question = Question.where(test_number: params[:test_number], 
                                 section: params[:section], 
                                 question_number: params[:question]
                                ).first
    end
    
    # TODO DRY this:
    sections = ['english', 'math', 'reading', 'science']
    default_section = 'english'
    @default_section_pageimage = "#{default_section}_pg1.jpg"
    @default_section_maxpage=Question.maxpage(1, default_section).to_i
    @maxpage_hash = {}
    sections.each {|sec| @maxpage_hash[sec]=Question.maxpage(1,sec).to_i }
    @maxpage_hash['science']=Question.maxpage(1, "science").to_i
    @questions = Question.order("test_number, section, question_number")
    @maxtest = Question.maximum("test_number") || 0
    
    @maxquestion = {}
    sections.each do |section|
      @maxquestion[section] = Question.where(test_number: 1, section: section).maximum("question_number") || 0
    end       
    @filename = "#{@question.section}_pg#{@question.page}.jpg"


    @user = User.find(session[:user_id])
  
    # @ans_choice = params[:ans_choice_radio]
    
 
   # Answer.create(question_id: question.id, user_id: user.id, selected_ans: ans_choice)
  
  end

  def submit
    answer = Answer.new
    answer.question_id = params[:q_id]
    answer.user_id = session[:user_id]
    answer.selected_ans = params[:ans]
    
    answer.save
    @answer = answer
  end


  def show
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
  end

end
