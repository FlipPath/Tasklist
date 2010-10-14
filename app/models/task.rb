class Task < ActiveRecord::Base
  belongs_to :list
  
  validates_presence_of :title
  
  acts_as_list :scope => :list
  
  class << self
    def ordered
      all
    end
    
    def open
      where(:closed => false)
    end
  end
  
  def toggle_close
    update_attribute :closed, !closed
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
