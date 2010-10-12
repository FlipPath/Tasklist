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
