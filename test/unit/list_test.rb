require 'test_helper'

class ListTest < ActiveSupport::TestCase
  setup do
    @user = Factory(:user, :username => "admin", :email => "admin@test.com")
    @list = Factory.build(:empty_list)
  end
  
  should validate_presence_of(:name)
  
  context "a new list" do
    setup do
      @list = @user.lists.create(@list.attributes)
    end
    
    should "have the creating user as a collaborator" do
      assert_contains @list.collaborators, @user
    end
    
    context "the first user" do
      should "be an admin" do
        assert @list.is_admin?(@user)
      end
      
      should "find this list in their managed lists" do
        @managed_lists = @user.lists.managed
        assert_equal @managed_lists.first, @list
      end
    end
  end
  
  context "for an existing list" do
    setup do
      @list = @user.lists.create(@list.attributes)
    end
    
    context "the second collaborator" do
      setup do
        @second_user = Factory(:user, :username => "bob", :email => "bob@test.com")
        @list.collaborators << @second_user
      end
      
      should "have two collaborators" do
        assert_equal 2, @list.collaborators.count
      end
      
      should "not be an admin" do
        assert !@list.is_admin?(@second_user)
      end
      
      should "not find the list in their managed lists" do
        @managed_lists = @second_user.lists.managed
        assert_not_equal @managed_lists.first, @list
      end
    end
  end
end
