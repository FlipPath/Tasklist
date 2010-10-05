class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  
  # make first user admin by default
  before_create :set_admin, :if => lambda { list.collaborators.count == 0 }
  
  private
  
  def set_admin
    self.admin = true
  end
end