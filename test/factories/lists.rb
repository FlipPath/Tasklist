Factory.define :invalid_list, :class => List do |f|
end

Factory.define :list do |l|
  l.name "Things to do"
end

Factory.define :empty_list, :class => List do |f|
  f.name "Music"
end

Factory.define :list_with_item, :class => List do |f|
  f.name "At the office"
  f.after_build do |l|
    l.tasks.build(:title => "Check email")
  end
end

Factory.define :list_with_ten_items, :class => List do |f|
  f.name "Lipsum"
  # f.after_build do |l|
  #   Faker::Lorem.sentences(10).each { |s| l.tasks.create(:task => s) }
  # end
end
