class List < ActiveRecord::Base
  attr_accessible :name, :user_ids
  
  has_many :list_associations
  has_many :users, :through => :list_associations
  has_one :owner, :through => :list_associations, :source => :user, :conditions => ["list_associations.role = ?", "owner"]
  has_many :collaborators, :through => :list_associations, :source => :user, :conditions => ["list_associations.role = ?", "collaborator"]
  
  has_many :group_associations, :order => "position DESC"
  has_many :groups, :through => :group_associations
  
  has_many :tasks, :order => "closed ASC, position DESC"
  
  validates_presence_of :name
  
  class << self
    def latest
      order(:created_at.desc)
    end
  end
  
  def channel
    Pusher["private-list-#{id}"]
  end
  
  def can_access_channel(channel_name)
    case channel_name
    when /^(?:presence|private)-list-(\d+)/ then $1 == id.to_s
    else false
    end
  end
end

# == Schema Info
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime