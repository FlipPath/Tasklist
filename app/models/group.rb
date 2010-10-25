class Group < ActiveRecord::Base
  has_many :group_associations, :order => "position DESC", :dependent => :destroy
  has_many :lists, :through => :group_associations, :order => "position DESC"
  belongs_to :user
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:user_id], :case_sensitive => false
  
  acts_as_list :scope => :user
  
  def tasks
    Task.all_for_group(self)
  end
  
  def channel
    Pusher["private-list-#{id}"]
  end
  
  def can_access_channel(channel_name)
    case channel_name
    when /^(?:presence|private)-group-(\d+)/ then $1 == id.to_s
    else false
    end
  end
end

# == Schema Info
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  name       :string(255)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
