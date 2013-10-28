class QuestionsController < ApplicationController
  skip_before_filter :authorization, except: [:modify, :edit_explanation]


  def delete
    Question.find(params[:id]).destroy
    respond_to do |format|
      format.json {render :json => Question.first}
    end 
  end

  def maxpage
    
    maxpage_item={}
    maxpage_item["current"]=Question.maxpage(params['test'],params['section'])
    
    
    respond_to do |format|
      format.json { render :json => maxpage_item}
    end
    
  end
  
  def answer
    @has_question = false
    @tests = Question.select("test_number").group(:test_number)
    @sections = Question.select("section").group(:section)
    
    @default_q = Question.first
    @num_questions = Question.where(test_number: @default_q.test_number, section: @default_q.section).count("id")
    
    if params[:section]
      #all this shit
      @question = Question.where(test_number: params[:test_number], 
            section: params[:section],
            question_number: params[:question_number]).first
      @has_question = true if @question
      @ans_choices = []
      (1..@question.num_ans_choices).each do |i|
        @ans_choices << @question.send("ans_choice_"+i.to_s)
      end
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def page_image
    @filename = "science page 3.jpg"
  end
  
  def modify

    
    @alphabetArray = Actprep::Application.alphabetArray
    @alphabetOrderHash = Actprep::Application.alphabetHash
    counter=0
    ('A'..'Z').each do |letter|
      @alphabetOrderHash[letter]=counter
      counter+=1
    end

    @answerChoiceOptions=[]
    @alphabetArray[0, @alphabetArray.length-4].each do |fl|
      flPosition=@alphabetOrderHash[fl]
      @answerChoiceOptions << @alphabetArray[flPosition,4].join(" ")
    end
    @alphabetArray[0, @alphabetArray.length-5].each do |fl|
      flPosition=@alphabetOrderHash[fl]
      @answerChoiceOptions << @alphabetArray[flPosition,5].join(" ")
    end

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
  end 
  
  def add
    Question.create(correct_ans: params[:correct_answer], 
                    num_ans_choices: params[:num_choice], 
                    question_number: params[:question_number], 
                    section: params[:section], 
                    test_number: params[:test], 
                    ans_choice_1: params[:choice1], 
                    page: params[:page],
                    explanation: params[:explanation])
    
    respond_to do |format|
      format.json {render :json => Question.all}
    end
   
  end
  
  def edit 
    Question.update(params[:id].to_i, 
                    :page => params[:page].to_i, 
                    :ans_choice_1 => params[:choice1], 
                    :correct_ans => params[:correct_answer],
                    :num_ans_choices => params[:num_choice])
    respond_to do |format|
      format.json {render :json => Question.find(params[:id].to_i)}
    end
  end
  
  
  def list 
    result = Question.where(test_number: params[:test], section: params[:section])
                     .order("test_number, section, question_number")
    respond_to do |format|
      format.json {render :json => result}
    end 
  end 
  
  def viewimage
    @filename = "#{params[:section]}_pg#{params[:page]}.jpg"
    section=params[:section]
    page = params[:page].to_i
    prev_page = page-1
    next_page = page+1
    @prev_link = "/questions/viewimage/#{section}/#{prev_page}"
    @next_link = "/questions/viewimage/#{section}/#{next_page}"
    
  end
  
  def findbyattributes
    result=Question.where(test_number: params[:test], section: params[:section], question_number: params[:question]).first
    respond_to do |format|
      format.json {render :json => result}
    end
  end
  
  def explanation
    @simple_explanation = Question.find(params[:id]).explanation || "No explanation available."
    @question = Question.find(params[:id])
  end

  def edit_explanation
    @hidenavbar = true
    @question = Question.find(params[:id])
  end
  def post_edit_explanation
    if params["upload_filename"]!=""
        #upload file
        #connect to server
    else
      @question = Question.update(params[:id].to_i, 
                    :explanation => params[:explanation])
    end
    redirect_to action: "modify"
  end


end



