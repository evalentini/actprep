class HomeworksController < ApplicationController
  # GET /homeworks
  # GET /homeworks.json
  
  skip_before_filter :authorization
  
  def index
    @homeworks = Homework.where(user_id: User.find(session[:user_id]))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @homeworks }
    end
  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
    @homework = Homework.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @homework }
    end
  end

  # GET /homeworks/new
  # GET /homeworks/new.json
  def new
    @homework = Homework.new
    @isquiz = false
    @isquiz = true if params[:isquiz].present?
    raise "only administrators can create quizzes" if @isquiz==true and User.find(session[:user_id]).role!="admin"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @homework }
    end
  end

  # GET /homeworks/1/edit
  def edit
    @homework = Homework.find(params[:id])
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    homework_info=params[:homework]
    homework_info[:user_id] = User.find(session[:user_id]).id
    @homework = Homework.new(homework_info)
      
    respond_to do |format|
      if @homework.save
        if params[:homework][:quiz]=="true"
          format.html { redirect_to action: "quizlist", notice: 'Quiz was successfully created.' }
        else
          format.html { redirect_to action: "index", notice: 'Homework was successfully created.' }
        end
        format.json { render json: @homework, status: :created, location: @homework }
      else
        format.html { render action: "new" }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /homeworks/1
  # PUT /homeworks/1.json
  def update
    @homework = Homework.find(params[:id])
    
    raise "only administrators can create quizzes" if @homework.quiz==true and User.find(session[:user_id]).role!="admin"

    respond_to do |format|
      if @homework.update_attributes(params[:homework])
        if @homework.quiz==true
          format.html { redirect_to action: "quizlist", notice: 'Homework was successfully updated.' }
        else
          format.html { redirect_to action: "index", notice: 'Homework was successfully updated.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework = Homework.find(params[:id])
    @quiz=@homework.quiz
    
    raise "only administrators can create quizzes" if @homework.quiz==true and User.find(session[:user_id]).role!="admin"
    
    
    @homework.destroy

    respond_to do |format|
      if @quiz==true
        format.html { redirect_to action: "quizlist" }
      else
        format.html { redirect_to homeworks_url }
      end
      format.json { head :no_content }
    end
  end
  
  def questionlist
    @homework=Homework.find(params[:id])
    @questions=@homework.questions.order("test_number, section, question_number ")
    unless params[:test_number].nil?
      @homework.addQuestion(params[:test_number], params[:section], params[:question])
    end
  end
  
  def removequestion
    @homework=Question.find(params[:id]).homework
    raise "only administrators can create quizzes" if @homework.quiz==true and User.find(session[:user_id]).role!="admin"
    Homework.removeQuestion(params[:id])
    redirect_to :action => "questionlist", :id=> @homework.id
  end
  
  def completionreport
  end
  
  def quizlist
    @homeworks = Homework.where(quiz: true)
  end
  
end
