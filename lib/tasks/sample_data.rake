require 'faker'

namespace :db do
  desc "Peupler la base de donnees avec des echantillons"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(:nom => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
				:pro => 0,
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  59.times do |n|
    nom  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
	pro = 0,
    password  = "foobar"
    User.create!(:nom => nom,
			:pro => pro,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_microposts
  User.limit(6).each do |user|
    40.times do
      content = Faker::Lorem.sentence(5)
      user.microposts.create!(:content => content)
    end
  end
end

def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end