namespace :populate do
  desc "Database custom drop"
  task :users  => :environment do
    puts "="*80
    puts 'creating users'
    puts "="*80
    10.times do |i|
      innerds = {email: Faker::Internet.safe_email, password: 'password'}
      puts "user: #{i+1} --- #{innerds}"
      User.create(innerds)
    end
  end

  task :groupings => :environment do
    puts "="*80
    puts 'creating groupings'
    puts "="*80
    4.times do |i|
      innerds = {title: Faker::Lorem.sentence(2, false, 1)}
      puts "groupings: #{i+1} --- #{innerds}"
      Grouping.create(innerds)
    end
  end

  task :forums => :environment do
    puts "="*80
  	puts 'creating forums'
    puts "="*80
  	30.times do |i|
      innerds = {title: Faker::Lorem.sentence(3, false, 15), parent_id: [nil,nil,(Forum.all.count > 0 ? Forum.all.sample.id : nil)].sample, created_by: User.all.sample.id, main_feed: [false,false,false,false,true].sample, grouping_id: [nil,nil,Grouping.all.sample.id].sample, locked: [false,false,false,false,true].sample}
      puts "forum: #{i+1} --- #{innerds}"
  		Forum.create(innerds)
  	end
  end

  task :topics => :environment do
    puts "="*80
    puts 'creating topics'
    puts "="*80
    100.times do |i|
      innerds = {title: Faker::Lorem.sentence(3, false, 15), body: Faker::Lorem.paragraph(3, false, 2), created_by: User.all.sample.id, sticky: [true, false, false, false, false].sample, locked: [false,false,false,false,true].sample, forum_id: Forum.all.sample.id}
      puts "topic: #{i+1} --- #{innerds}"
      Topic.create(innerds)
    end
  end

  task :comments => :environment do
    puts "="*80
    puts 'creating comments'
    puts "="*80
    500.times do |i|
      innerds = { body: Faker::Lorem.paragraph(3, false, 2), created_by: User.all.sample.id, topic_id: Topic.all.sample.id}
      puts "comments: #{i+1} --- #{innerds}"
      Comment.create(innerds)
    end
  end

end