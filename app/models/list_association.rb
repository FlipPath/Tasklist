class ListAssociation < ActiveRecord::Base
  ROLES = %w[owner collaborator]
  belongs_to :list
  belongs_to :user
  
  before_create :set_role
  
  private
  
  def set_role
    self.role = case first_assoociation?
    when true then "owner" else "collaborator"
    end
  end
  
  def first_assoociation?
    self.class.where(:list_id => list_id).count == 0
  end
end

# == Schema Info
#
# Table name: list_associations
#
#  id         :integer         not null, primary key
#  list_id    :integer
#  user_id    :integer
#  role       :string(255)
#  created_at :datetime
#  updated_at :datetime