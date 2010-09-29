# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
if Rails.env == "development"
  puts 'EMPTY THE MONGODB DATABASE'
  Mongoid.master.collections.reject { |c| c.name == 'system.indexes'}.each(&:drop)
end
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :username => "user_test", :name => 'First User', :email => 'user@test.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
