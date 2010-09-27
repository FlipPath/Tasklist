class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :task
  
  attr_accessible :task
  
  validates_presence_of :task
  
  class << self
    def latest
      order_by(:created_at.desc)
    end
  end
end