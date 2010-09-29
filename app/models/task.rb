class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :task
  field :completed, :type => Boolean, :default => false
  field :position, :type => Integer
  
  embedded_in :list, :inverse_of => :tasks
  
  attr_accessible :task, :position
  
  validates_presence_of :task
  
  before_create :set_position
  
  class << self
    def latest
      order_by(:created_at.desc)
    end
    
    def ordered
      order_by(:position.desc, :created_at.desc)
    end
  end
  
  def toggle_complete
    self.completed = !completed
    self.save
  end
  
  def move_to(new_position)
    return if new_position == position
    
    limit = list.tasks.count
    new_position = limit - 1 if new_position > limit
    new_position = 0 if new_position < 0 
    
    old_position = position
    moving_up = (new_position > position)
    
    list.tasks.each do |t|
      if t.position == old_position # is this me?
        t.position = new_position # set new position
      elsif moving_up # did I move up in value?
        if t.position == new_position # is this what I'm replacing?
          t.position -= 1 # move it down, i'm moving into place
        elsif t.position > old_position # is it high than where I started?
          if t.position < new_position # is it lower than where I'm going
            t.position -= 1 # move it down, i'm going above it
          else # it's higher than I'm going
            # leave them alone
          end
        elsif t.position < old_position # is it below where I moved from
          # leave them alone
        end
      else # I moved down in value
        if t.position == new_position # is this what I'm replacing?
          t.position += 1 # move it up, I'm coming down
        elsif t.position < old_position # is it below where I started
          if t.position > new_position # is it above where I'm going
            t.position += 1 # move it up, I'm going below it
          else # it's below where I'm going
            # leave them alone
          end
        elsif t.position > old_position # is it higher than I started?
          # leave them alone
        end
      end
      t.save
    end
  end
  
  protected
  
  def set_position
    self.position = list.tasks.count
  end
end