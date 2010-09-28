class List
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  
  embeds_many :tasks
  
  attr_accessible :name
  
  validates_presence_of :name
  
  class << self
    def latest
      order_by(:created_at.desc)
    end
  end
end