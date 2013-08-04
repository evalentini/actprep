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

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 1, 
question_text: "What is 1 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6"
)