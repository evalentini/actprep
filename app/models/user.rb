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
