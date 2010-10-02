class List
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  
  embeds_many :tasks
  references_many :users, :stored_as => :array, :inverse_of => :lists
  
  attr_accessible :name, :user_ids
  
  validates_presence_of :name
  
  class << self
    def latest
      order_by(:created_at.desc)
    end
  end
  
  def channel
    Pusher["private-list-#{id}"]
  end
  
  def share(user)
    user.lists << self
    user.save
  end
  
  def shared?
    users.count > 1
  end
end