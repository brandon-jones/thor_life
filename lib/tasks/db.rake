namespace :db do
  desc "Database custom drop"
  task :mydrop do
  	puts 'dropping databases'
    system("rake db:drop RAILS_ENV=test && rake db:drop RAILS_ENV=development")
    puts 'creating the databases'
    system("rake db:create RAILS_ENV=test && rake db:create RAILS_ENV=development")
    puts 'migrating databases'
    system("rake db:migrate RAILS_ENV=test && rake db:migrate RAILS_ENV=development")
  end

  task :mymigrate do
    puts 'migrating databases'
    system("rake db:migrate RAILS_ENV=test && rake db:migrate RAILS_ENV=development")
  end

  task :prime => :environment do
    Rake::Task["db:reset"].execute
    Rake::Task["populate:users"].execute
    # Rake::Task["populate:groupings"].execute
    Rake::Task["populate:forums"].execute
    Rake::Task["populate:topics"].execute
    Rake::Task["populate:comments"].execute
    Rake::Task["populate:games"].execute
    Rake::Task["populate:game_instances"].execute
    Rake::Task["populate:perks"].execute
    Rake::Task["populate:packages"].execute
    Rake::Task["populate:carts"].execute
    Rake::Task["populate:cart_items"].execute
  end
end