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
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 232, 
question_text: "What is 434+ 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 34343, 
question_text: "What is 3 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 2432, 
question_text: "What is23432 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 24324, 
question_text: "What 2432is 1 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 54, 
question_text: "What453 1 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 12121, 
question_text: "What is 1 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 23, 
question_text: "What is 232 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 455, 
question_text: "Wh4at is 5 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 454, 
question_text: "What is 6 + 1", 
section: "math", 
test_number: 1, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)

Question.create(
correct_ans: 1, 
num_ans_choices: 5, 
question_number: 86, 
question_text: "What is 3 + 1", 
section: "math", 
test_number: 3, 
ans_choice_1: "2",
ans_choice_2: "3",
ans_choice_3: "4",
ans_choice_4: "5",
ans_choice_5: "6",
user_id: 1
)