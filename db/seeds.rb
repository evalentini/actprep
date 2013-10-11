# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.count == 0
User.create(email: "bob@bob.com", 
encrypted_password: "d9280d31c2d3df4c7a0742abbf367c6d5653699c6c20025cbedafbd42a86bb85" , 
salt: "9x1Z", username: "bob")
end

#create default admin user with aubrey's email

unless User.find_by_email("asharman@griffithtutoring.org")
  User.create(
    email: "asharman@griffithtutoring.org",
    encrypted_password:  "7ffb3c76e1ba0f5822e931c812653d311587e824a61921f91fa6b470f03cf7f0",
    salt:  "x79Z",
    role: "admin",
    username: "asharman"
  )
end 

#locked ADMIN user with my email 

unless User.find_by_email("evan.valentini@gmail.com")
  User.create(
    email: "evan.valentini@gmail.com",
    encrypted_password: "7ffb3c76e1ba0f5822e931c812653d311587e824a61921f91fa6b470f03cf7f0",
    salt:  "x79Z",
    role: "admin",
    username: "evan.valentini",
    locked: true 
  )
end

#locked STUDENT user with my email 

unless User.find_by_email("evalentini@welshcarson.com")
  User.create(
    email: "evalentini@welshcarson.com",
    encrypted_password: "7ffb3c76e1ba0f5822e931c812653d311587e824a61921f91fa6b470f03cf7f0",
    salt:  "x79Z",
    role: "student",
    username: "evalentini", 
    locked: true   
  )
end

unless Question.where(test_number:1, section: "english", question_number:1).count>0
  Question.create(
    test_number: 1,
    section: "english",
    question_number: 1,
    ans_choice_1: "A",
    num_ans_choices: 4,
    correct_ans: 3, 
    page: 1,
    explanation: "Hey question 1. Your answer should've been blah because blah "
    )
    
    q_id=Question.where(test_number:1, section: "english", question_number:1).first.id
    
  else 
    
    q_id=Question.first.id
    
end


unless Answer.count>0
  Answer.create(
    question_id: q_id, 
    selected_ans: 1, 
    user_id: User.first.id  
  )
end

unless Question.where(test_number:1, section: "english", question_number:2).count>0
  Question.create(
    test_number: 1,
    section: "english",
    question_number: 2,
    ans_choice_1: "A",
    num_ans_choices: 4,
    correct_ans: 3, 
    page: 1,
    explanation: "Your answer should've been blah because blah "
    )
end


#Question.create(
#correct_ans: 1, 
#num_ans_choices: 5, 
#question_number: 1, 
#section: "science", 
#test_number: 1, 
#ans_choice_1: "A",
#page: 2
#)
