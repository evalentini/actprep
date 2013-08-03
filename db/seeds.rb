# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "bob@bob.com", 
encrypted_password: "d9280d31c2d3df4c7a0742abbf367c6d5653699c6c20025cbedafbd42a86bb85" , 
salt: "9x1Z", username: "bob")

