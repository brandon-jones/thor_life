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
end