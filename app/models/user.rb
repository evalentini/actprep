class User < ActiveRecord::Base
  
  attr_accessible :email, :encrypted_password, :role, :salt, :username 
  has_many :answers, dependent: :destroy
  
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
    
  def answerSummary
    #find unique questions answered by user
    questions = Answer.select("question_id as q_id").where(user_id: self.id).group("question_id")
    #find latest answer for each question 
    result = []
    questions.each do |q|
    
      mrdate = Answer.where(question_id: q.q_id, user_id: self.id).maximum("created_at")
      most_recent_ans = Answer.where(question_id: q.q_id, user_id: self.id, created_at: mrdate).first.selected_ans      
      is_correct = "no"
      is_correct = "yes" if most_recent_ans == Question.find(q.q_id).correct_ans
      
      result << {:question_id => q.q_id,
                 :test => Question.find(q.q_id).test_number, 
                 :section => Question.find(q.q_id).section, 
                 :question => Question.find(q.q_id).question_number, 
                 :correct => is_correct}
    end
    
    result
      
  end
  
  
  def pctAnswered
    answered_q = Answer.select(:question_id).where(user_id: self.id).group("question_id")
    num_answered=0
    answered_q.each {|q| num_answered+=1 }
    total_num = Question.count(:id).to_f
    
    (100*(num_answered/total_num)).round
  
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

 

end
