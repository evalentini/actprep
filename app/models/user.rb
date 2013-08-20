class User < ActiveRecord::Base
  attr_accessible :email, :encrypted_password, :role, :salt, :username 
  has_many :questions, dependent: :destroy
  def check_pwd(pwd)
  	hash_pwd = self.salt + pwd
  	hash_pwd = Digest::SHA2.hexdigest(hash_pwd)
  	
  	if hash_pwd == self.encrypted_password
  		return true
  	else
  		return false
  	end



  end

 

end
