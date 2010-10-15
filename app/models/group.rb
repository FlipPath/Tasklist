class Group < ActiveRecord::Base
  has_many :group_associations, :order => "position DESC", :dependent => :destroy
  has_many :lists, :through => :group_associations, :order => "position DESC"
  belongs_to :user
  
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:user_id], :case_sensitive => false
end

# == Schema Info
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime