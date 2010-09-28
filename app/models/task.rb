class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :task
  field :completed, :type => Boolean, :default => false
  
  embedded_in :list, :inverse_of => :tasks
  
  attr_accessible :task
  
  validates_presence_of :task
  
  class << self
    def latest
      order_by(:created_at.desc)
    end
  end
  
  def toggle_complete
    self.completed = !completed
    self.save
  end
end