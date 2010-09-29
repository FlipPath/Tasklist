Factory.define :valid_list, :class => List do |f|
  f.name "Around the house"
end

Factory.define :invalid_list, :class => List do |f|
end

Factory.define :empty_list, :class => List do |f|
  f.name "Music"
end

Factory.define :list_with_item, :class => List do |f|
  f.name "At the office"
  f.after_build do |l|
    l.tasks.create(:task => "Check email")
  end
end

Factory.define :list_with_ten_items, :class => List do |f|
  f.name "Lipsum"
  f.after_build do |l|
    Faker::Lorem.sentences(10).each { |s| l.tasks.create(:task => s) }
  end
end
