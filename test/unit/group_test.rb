require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  should have_many(:group_associations)
  should have_many(:lists).through(:group_associations)
  should belong_to(:user)
  
  should validate_presence_of(:name)
  
  context "given an existing group" do
    setup do
      @group = Factory(:group)
      @list = Factory(:list)
    end
    
    should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive
    
    context "with a single list" do
      setup do
        @group.lists << @list
      end
      
      should "have one list" do
        assert_equal 1, @group.lists.count
      end
      
      should "contain the list" do
        assert_contains @group.lists, @list
      end
    end
    
    context "with 5 lists" do
      setup do
        @group.lists << @list
        4.times { @group.lists << Factory(:list) }
      end
      
      should "have 5 lists" do
        assert_equal 5, @group.lists.count
      end
      
      should "contain the first list" do
        assert_contains @group.lists, @list
      end
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
#  created_at :datetime
#  updated_at :datetime