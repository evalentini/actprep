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


Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 1, 
section: "science", 
test_number: 1, 
ans_choice_1: "A",
ans_choice_2: "B",
ans_choice_3: "C",
ans_choice_4: "D",
ans_choice_5: "E",
page: 2
)
