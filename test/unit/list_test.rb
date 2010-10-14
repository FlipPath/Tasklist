require 'test_helper'

class ListTest < ActiveSupport::TestCase
  should have_many(:list_associations)
  should have_many(:users).through(:list_associations)
  should have_many(:tasks)
  
  should validate_presence_of(:name)
  
  context "given an existing list" do
    setup do
      @user = Factory(:user)
      @list = Factory.build(:list)
      @user.lists << @list
    end
    
    should "have user as owner" do
      assert_equal @user, @list.owner
    end
    
    context "for shared list" do
      context "with 5 collaborators" do
        should "have 5 collaborators" do
          5.times { @list.users << Factory(:user) }
          assert_equal 5, @list.collaborators.count
        end
      end
    end
  end
end

# == Schema Info
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime