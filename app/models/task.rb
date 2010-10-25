class Task < ActiveRecord::Base
  belongs_to :list
  
  validates_presence_of :title
  
  acts_as_list :scope => :list
  
  named_scope :all_for_group, lambda{|group|{
    :joins      => {:list, :group_associations},
    :conditions => {:group_associations => {:group_id => group.id}},
    :select     => "tasks.*, lists.id" }
  }
  
  class << self
    def ordered
      all
    end
    
    def open
      where(:closed => false)
    end
    
    def closed
      where(:closed => true)
    end
    
    def important
      where(:important => true)
    end
  end
  
  def toggle_close
    update_attribute :closed, !closed
  end
  
  def toggle_important
    update_attribute :important, !important
  end
end

# == Schema Info
#
# Table name: tasks
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  closed     :boolean
#  position   :integer
#  list_id    :integer
#  created_at :datetime
#  updated_at :datetime
