Factory.define :valid_task, :class => Task do |t|
  t.task "Take garbage to curb"
end

Factory.define :invalid_task, :class => Task do |t|
end
