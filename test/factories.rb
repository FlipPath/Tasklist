Factory.sequence :username do |i|
  Faker::Internet.user_name + i.to_s  # make sure it's unique by appending sequence number
end

Factory.sequence :time do |x|
  Time.now - x.hours
end

#----------------------------------------------------------------------------
Factory.define :user do |f|               
  f.username              { Factory.next(:username) }
  f.email                 { Faker::Internet.email }
  f.name                  { Faker::Name.name }
  f.password              "password"
  f.password_confirmation {|u| u.password }
end

#----------------------------------------------------------------------------
Factory.define :list_association do |f|
  f.user                  {|l| l.association(:user) }
  f.list                  {|l| l.association(:list) }
end

#----------------------------------------------------------------------------
Factory.define :list do |f|
  f.name                  { Faker::Lorem.sentence[0,64] }
end

#----------------------------------------------------------------------------
Factory.define :list_with_tasks, :class => List  do |f|
  f.name                  { Faker::Lorem.sentence[0,64] }
  f.after_build do |l|
    l.tasks = [Factory.build(:task, :list => l), Factory.build(:task, :list => l)]
  end
end

#----------------------------------------------------------------------------
Factory.define :group_association do |f|
  f.group                 {|l| l.association(:group) }
  f.list                  {|l| l.association(:list) }
end

# ----------------------------------------------------------------------------
Factory.define :group do |f|
  f.user                  {|g| g.association(:user) }
  f.name                  { Faker::Lorem.sentence[0,64] }
end

# ----------------------------------------------------------------------------
Factory.define :task do |f|
  f.title                 { Faker::Lorem.sentence[0,64] }
  f.closed                false
  f.list                  {|l| l.association(:list) }
end
