# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "seeding database"
king = User.create(email: 'support@thorlife.com', password: 'password', password_confirmation: 'password')
scott = User.create(email: 'scott.tuscher@gmail.com', password: 'password', password_confirmation: 'password', username: 'Echthelions')
AdminRole.create(user_id: king.id, admin_type: 'King')
AdminRole.create(user_id: scott.id, admin_type: 'King')
puts "admin role created go change your shite fast"