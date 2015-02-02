namespace :populate do
  desc "Database custom drop"
  task :users  => :environment do
    puts 'creating 10 random users'
    10.times do |i|
      puts "user: #{i+1}"
      User.create(email: Faker::Internet.safe_email, password: 'password')
    end
  end
end