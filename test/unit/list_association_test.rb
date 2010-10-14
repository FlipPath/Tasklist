require 'test_helper'

class ListAssociationTest < ActiveSupport::TestCase
  setup do
    @owner = Factory(:user)
    @list = Factory.build(:list)
  end
  
  context "given a new list" do  
    should "set role to owner" do
      @association = @owner.list_associations.create(:list => @list)
      assert_equal "owner", @association.role
    end
  end
  
  context "given an existing list" do
    setup do
      @owner.lists << @list
    end
    
    context "sharing" do
      setup do
        @collaborator = Factory(:user)
      end
      
      should "be collaborator" do
        @association = @collaborator.list_associations.create(:list => @list)
        assert_equal "collaborator", @association.role
      end
    end
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