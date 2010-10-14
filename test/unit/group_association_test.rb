require 'test_helper'

class GroupAssociationTest < ActiveSupport::TestCase
  should belong_to(:group)
  should belong_to(:list)
  
  setup do
    @association = Factory(:group_association)
    @group = @association.group
  end
  
  context "for first group" do  
    should "have position of 1" do
      assert_equal 1, @association.position
    end
  end
  
  context "for second group" do
    setup do
      @second_association = Factory(:group_association, :group => @group)
    end
    
    should "have position of 2" do
      assert_equal 2, @second_association.position
    end
  end
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