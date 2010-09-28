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
    l.tasks << l.tasks.create(:task => "Check email")
  end
end
