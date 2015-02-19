namespace :populate do
  desc "Database custom drop"
  task :users  => :environment do
    puts "="*80
    puts 'creating users'
    puts "="*80
    100.times do |i|
      innerds = {email: Faker::Internet.safe_email, password: 'password'}
      puts "user: #{i+1} --- #{innerds}"
      User.create(innerds)
    end
  end

  task :games => :environment do
    puts "="*80
    puts 'creating games'
    puts "="*80
    games = [ 'Amra III', 'Minecraft', 'Day Z', 'Some other game' ]
    games.count.times do |i|
      innerds = { name: games[i] }
      puts "games: #{i+1} --- #{innerds}"
      Game.create(innerds)
    end 
  end

  task :game_instances => :environment do
    puts "="*80
    puts 'creating game instances'
    puts "="*80
    15.times do |i|
      innerds = { game_id: Game.all.sample.id, server_name:  Faker::Commerce.product_name, server_address: Faker::Internet.url, server_port: Faker::Number.number(3).to_i, mod_list: Faker::Lorem.words.join(',') }
      puts "game_instances: #{i+1} --- #{innerds}"
      GameInstance.create(innerds)
    end
  end

  task :user_game_ids => :environment do  
    puts "="*80
    puts 'creating user game ids'
    puts "="*80
    60.times do |i|
      innerds = { game_id: Game.all.sample.id, in_game_name: Faker::Internet.user_name, user_id: User.all.sample.id }
      puts "user_game_ids: #{i+1} --- #{innerds}"
      UserGameId.create(innerds)
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
  	60.times do |i|
      innerds = {title: Faker::Lorem.sentence(3, false, 15), parent_id: [nil,(Forum.all.count > 0 ? Forum.all.sample.id : nil),(Forum.all.count > 0 ? Forum.all.sample.id : nil)].sample, created_by: User.all.sample.id, main_feed: [false,false,false,false,true].sample, grouping_id: [nil,nil,Grouping.all.sample.id].sample, locked: [false,false,false,false,true].sample}
      puts "forum: #{i+1} --- #{innerds}"
  		Forum.create(innerds)
  	end
    Game.all.each do |game|
      Forum.all.sample.update_attribute(:game_id, game.id)
    end
    GameInstance.all.each do |game_instance|
      Forum.all.sample.update_attribute(:game_instance_id, game.id)
    end
  end

  task :topics => :environment do
    puts "="*80
    puts 'creating topics'
    puts "="*80
    150.times do |i|
      innerds = {title: Faker::Lorem.sentence(3, false, 15), body: Faker::Lorem.paragraph(3, false, 2), created_by: User.all.sample.id, sticky: [true, false, false, false, false].sample, locked: [false,false,false,false,true].sample, forum_id: Forum.all.sample.id}
      puts "topic: #{i+1} --- #{innerds}"
      Topic.create(innerds)
    end
  end

  task :comments => :environment do
    puts "="*80
    puts 'creating comments'
    puts "="*80
    750.times do |i|
      innerds = { body: Faker::Lorem.paragraph(3, false, 2), created_by: User.all.sample.id, topic_id: Topic.all.sample.id}
      puts "comments: #{i+1} --- #{innerds}"
      Comment.create(innerds)
    end
  end

  task :perks => :environment do  
    puts "="*80
    puts 'creating perks'
    puts "="*80
    50.times do |i|
      innerds = { title: Faker::Company.catch_phrase, game_instance_id: [nil,nil,GameInstance.all.sample.id], description: Faker::Lorem.paragraph, price: Faker::Commerce.price, game_id: [nil,Game.all.sample.id,Game.all.sample.id].sample }
      puts "perks: #{i+1} --- #{innerds}"
      Perk.create(innerds)
    end
  end

  task :packages => :environment do 
    puts "="*80
    puts 'creating packages'
    puts "="*80
    10.times do |i|
      perks = Perk.where(game_id: Game.all.sample.id)
      perk_ids = []
      price = 0
      total = Random.rand(10)
      count = 0
      kill_switch = 0
      while count < total && kill_switch < 10
        perk = perks.sample
        if perk_ids.include?(perk.id)
          kill_switch += 1
        else
          kill_switch = 0
          perk_ids << perk.id
          price += perk.price_in_cents
          count += 1
        end
      end
      lower_price = price.to_i/2
      lower_price = Random.rand(lower_price) unless lower_price == 0
      lower_price = price - lower_price
      innerds = { title: Faker::Company.catch_phrase, price_in_cents: [lower_price,price,price].sample, perk_ids: perk_ids.join(',') }
      puts "perks: #{i+1} --- #{innerds}"
      Package.create(innerds)
    end
  end

  task :carts => :environment do
    puts "="*80
    puts 'creating carts'
    puts "="*80
    20.times do |i|
      delivered = [false, false, false, true].sample
      innerds = { user_id: User.all.sample.id, total: 0 , delivered: delivered, delivered_by: (delivered ? User.all.sample.id : nil), delivered_on: (delivered ? DateTime.now.utc : nil), donation_id: Random.rand(50)}
      puts "perks: #{i+1} --- #{innerds}"
      Cart.create(innerds)
    end
    User.all.each do |user|
      if [false, true].sample
        if cart = Cart.where(user_id: user.id).sample
          cart.update_attribute(:donation_id, nil)
        end
      end
    end
  end

  task :cart_items => :environment  do
    puts "="*80
    puts 'creating cart items'
    puts "="*80
    60.times do |i|
      item_type = ['Perk', 'Perk', 'Perk', 'Package'].sample
      item_id = item_type.constantize.all.sample.id
      price = item_type.constantize.find_by_id(item_id).price
      innerds = { item_id: item_id, item_type: item_type, price: price, cart_id: Cart.all.sample.id }
      puts "perks: #{i+1} --- #{innerds}"
      CartItem.create(innerds)
      cart = Cart.find_by_id(innerds[:cart_id])
      cart.update_attribute(:total, (cart.total + price))
    end
  end

end