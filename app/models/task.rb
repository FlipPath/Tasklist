class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :task
  field :completed, :type => Boolean, :default => false
  
  attr_accessible :task
  
  validates_presence_of :task
  
  class << self
    def latest
      order_by(:created_at.desc)
    end
  end
  
  def complete
    self.completed = true
    self.save
  end
end