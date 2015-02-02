# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "seeding database"
user = User.create(email: 'support@thorlife.com', password: 'password', password_confirmation: 'password')
puts user.to_s
AdminRole.create(user_id: user.id, admin_type: 'king')
puts "admin role created go change your shite fast"