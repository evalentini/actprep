class User < ActiveRecord::Base
  
  attr_accessible :email, :encrypted_password, :role, :salt, :username, :locked, :ominauth_user, :uid, 
                  :firstname, :lastname, :usertype,
                  :provider, :oauth_token, :oauth_expires_at


  has_many :answers, dependent: :destroy
  has_many :homeworks
  has_many :tasks
  
  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_presence_of :username
  
  def check_pwd(pwd)
  	hash_pwd = self.salt + pwd
  	hash_pwd = Digest::SHA2.hexdigest(hash_pwd)
  	
  	if hash_pwd == self.encrypted_password
  		return true
  	else
  		return false
  	end

  end

  
  #----dashboard report calculations--------
  
 
  
  
  def self.totalStudents(timePeriod="0.days.ago")
    User.where(role: "student").where("created_at <= ?", eval(timePeriod) ).count
  end
  
  def self.questionsAnswered(timePeriod="0.days.ago")
    uniqAnswers=Answer.select("count(*)").where("created_at <?", eval(timePeriod)).group("user_id, question_id")
    count=0
    uniqAnswers.each {|ans| count+=1}
    (count.to_f/User.totalStudents(timePeriod).to_f).round(1)
  end
  
  def self.minSpent(timePeriod="0.days.ago")
    ((Answer.where("created_at <= ?", eval(timePeriod)).sum(:timetaken).to_f/60)/User.totalStudents(timePeriod).to_f).round(1)
  end
    
  def answerSummary
    #find unique questions answered by user
  
    questions = Answer.select("question_id as q_id").where(user_id: self.id).group("question_id")
    #find latest answer for each question 
    result = []
    Question.all.each do |q|
      
      #check if user answered question 
      answered=false
      answered=true if Answer.where(user_id: self.id, question_id: q.id).count>0
      
      question_id=q.id.to_i
      test=Question.find(q.id).test_number.to_i
      section=Question.find(q.id).section
      question=Question.find(q.id).question_number
      is_correct=" "
      attempted="no"
      timetaken="--"
      
      
      if (answered==true) 
        
        #mrdate = Answer.where(question_id: q.id, user_id: self.id).maximum("created_at")
        mr_id=Answer.where(question_id: q.id, user_id:self.id).order("created_at desc").limit(1).first.id
        most_recent_ans=Answer.find(mr_id)
                
        #most_recent_ans = Answer.where(question_id: q.id, user_id: self.id, created_at: mrdate).first.selected_ans
        is_correct = "no"
        is_correct = "yes" if most_recent_ans.correct
        attempted="yes"
        unless most_recent_ans.timetaken.nil?
          timetaken=most_recent_ans.timeTakenString
          #timetaken=(most_recent_ans.timetaken.to_f/60).floor.to_s
          #timetaken=timetaken+":"+(most_recent_ans.timetaken-(60*(most_recent_ans.timetaken.to_f/60).floor)).to_s
        end
        
        
      end
      
      
       result << {:question_id => question_id,
                  :test => test, 
                  :section => section, 
                  :question => question, 
                  :correct => is_correct,
                  :attempted => attempted,
                  :timetaken => timetaken}
      
#    questions.each do |q|
    
#      mrdate = Answer.where(question_id: q.q_id, user_id: self.id).maximum("created_at")
#      most_recent_ans = Answer.where(question_id: q.q_id, user_id: self.id, created_at: mrdate).first.selected_ans      
#      is_correct = "no"
#      is_correct = "yes" if most_recent_ans == Question.find(q.q_id).correct_ans
      
#      result << {:question_id => q.q_id,
#                 :test => Question.find(q.q_id).test_number, 
#                 :section => Question.find(q.q_id).section, 
#                 :question => Question.find(q.q_id).question_number, 
#                 :correct => is_correct}
    end
    
    
    # sorted_result = result.sort { |a,b| a[:question] == b[:question]? ( a[:section] ==
    # b[:section]? a[:test] <=> b[:test] : a[:section] <=> b[:section] ) : b[:question] <=> a[:question] }

    correct_questions = []
    result.each {|r| correct_questions << r if r[:correct]=="yes" && r[:attempted]=="yes"}
    correct_questions = User.sortArray(correct_questions)

    incorrect_questions = []
    result.each {|r| incorrect_questions << r if r[:correct]=="no" && r[:attempted]=="yes"}
    incorrect_questions = User.sortArray(incorrect_questions)
    
    not_attempted = []
    result.each {|r| not_attempted << r if r[:attempted]=="no"}
    not_attempted = User.sortArray(not_attempted)
    
    final_result = {}
    final_result[:correct]=correct_questions
    final_result[:incorrect]=incorrect_questions
    final_result[:not_attempted]=not_attempted
    
    
    
 #   sorted_result = result.sort { |a,b| a[:test] == b[:test]? ( a[:section] ==
 #   b[:section]? a[:question] <=> b[:question] : a[:section] <=> b[:section] ) : b[:test] <=> a[:test] }
    
    
    
    final_result
      
  end
  
  
  def pctAnswered
    answered_q = Answer.select(:question_id).where(user_id: self.id).group("question_id")
    num_answered=0
    answered_q.each {|q| num_answered+=1 }
    total_num = Question.count(:id).to_f
    
    (100*(num_answered/total_num)).round
  
  end
  
  #------authentication and password management 
  
  #--facebook authentication 
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.salt="AAAA"
      user.role="student" if user.role.nil?
      user.omniauth_user=true
      user.username=auth.info.email
      user.email=auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  
  
  def editWithPwd(argHash)
    u_id=self.id
    salt=self.salt
    e_pwd=Digest::SHA2.hexdigest(salt+argHash['pwd'])
    User.update(u_id, 
                :email=>argHash['email'], 
                :username=>argHash['username'], 
                :role=>argHash['role'],
                :encrypted_password=>e_pwd)
    true
  end
  
  
  def self.make_with_pwd(email, username, password, role)
    salt = User.rand_string(4)
    encrypted_password = Digest::SHA2.hexdigest(salt+password)
    User.create({:email => email, :username => username, :salt => salt, :encrypted_password => encrypted_password, :role => role}) 
  end 
  
  def self.rand_pwd
    User.rand_string(10)
  end
  
  def self.rand_string(i)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    (0...i).map{ o[rand(o.length)] }.join
  end
  
  def self.sortArray(result, test=:test, section=:section, question=:question) 
    result.sort { |a,b| a[test] == b[test]? ( a[section] ==
    b[section]? a[question] <=> b[question] : a[section] <=> b[section] ) : b[test] <=> a[test] }
    
  end
  
  def self.emailListHash
    emaillist={}
    User.order("email asc").each do |user|
      emaillist[user.email]=user.email
    end
    emaillist
  end
  
  def currentFriendIds
    friendlist=[]
    Friendship.where(tutor_id: self.id, approved: true).each do |friend|
      friendlist << User.find(friend.student_id).id
    end
    friendlist
  end
  
  def remainingPossibleFriends
    emaillist=User.emailListHash
    Friendship.where(tutor_id: self.id).each do |friend|
      emaillist.delete(User.find(friend.student_id).email)
    end
    emaillist
  end
  
  def remainingPossibleStudentFriends
    emaillist={}
    User.where(usertype: "student").order("email asc").each do |user|
      emaillist[user.email]=user.email
    end
    Friendship.where(tutor_id: self.id).each do |friend|
      emaillist.delete(User.find(friend.student_id).email)
    end
    emaillist
  end
  
  def checkfriend(friendid)
    if Friendship.where(tutor_id: self.id, student_id: friendid).count>0
      if (Friendship.where(tutor_id: self.id, student_id: friendid).first.approved==true)
        return true
      else
        return false
      end
    else
      return false 
    end
  end
  
  def assignedHomework(id)
    if Tasks.where(student_id: self.id, homework_id: id).count > 0 
      return true
    else
      return false
    end
  end
  
  def homeworkAssignments
    homeworkids="-999"
    Tasks.where(student_id: self.id).each do |task|
      homeworkids+=", #{task.homework_id}"
    end
    Homework.where("id IN (#{homeworkids})").order("due asc")
  end

end
