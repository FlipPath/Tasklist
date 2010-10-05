class List < ActiveRecord::Base
  attr_accessible :name, :user_ids
  
  has_many :collaborations
  has_many :collaborators, :through => :collaborations, :source => :user
  
  has_many :tasks, :order => "position DESC"
  
  validates_presence_of :name
  
  class << self
    def latest
      order(:created_at.desc)
    end
  end
  
  def is_admin?(user)
    !!collaborations.where(:user_id => user.id, :admin => true).first
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