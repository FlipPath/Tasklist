class GroupAssociation < ActiveRecord::Base
  belongs_to :group
  belongs_to :list
  
  acts_as_list :scope => :group
end


# == Schema Info
#
# Table name: group_associations
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  list_id    :integer
#  position   :integer
#  created_at :datetime
#  updated_at :datetime