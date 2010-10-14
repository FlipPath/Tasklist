require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_not allow_mass_assignment_of(:name)
  should_not allow_mass_assignment_of(:username)
  should_not allow_mass_assignment_of(:email)
  should_not allow_mass_assignment_of(:password)

  should have_many(:groups).dependent(:destroy)
  should have_many(:list_associations)
  should have_many(:lists).through(:list_associations)

  should validate_presence_of(:username)
  should validate_presence_of(:name)

  context "given an existing user" do
    setup do
      @user = Factory(:user)
    end
    
    should validate_uniqueness_of(:username).case_insensitive
    should validate_uniqueness_of(:email).case_insensitive
    
    context "for pusher related method" do
      context "private_channel_name method" do
        should "match regex" do
          assert_match /private-user-\d+/, @user.private_channel_name
        end
      end
      
      context "channel method" do
        should "return Pusher::Channel instance" do
          assert_instance_of Pusher::Channel, @user.channel
        end
      end
      
      context "channel authorization method" do
        context "valid channels" do
          should "access private channel" do
            assert @user.can_access_channel("private-user-#{@user.id}")
          end
          
          should "access presence channel" do
            assert @user.can_access_channel("presence-user-#{@user.id}")
          end
        end
        
        context "invalid channels" do
          should "not access private channel" do
            assert !@user.can_access_channel("private-user-#{@user.id * 2}")
          end
          
          should "not access presence channel" do
            assert !@user.can_access_channel("presence-user-#{@user.id * 2}")
          end
          
          should "deny access to invalid channel" do
            assert !@user.can_access_channel("foo-bar-quz")
          end
        end
      end
    end
    
    context "has many lists" do
      setup do
        @list = Factory.build(:list)
      end
      
      context "having one list" do
        setup do
          @user.lists << @list
        end
        
        should "have one list" do
          assert_equal 1, @user.lists.count
        end
        
        should "contain the list" do
          assert_contains @user.lists, @list
        end
        
        should "contain the list in owned lists" do
          assert_contains @user.owned_lists, @list
        end
        
        should "not contain the list in shared lists" do
          assert_does_not_contain @user.shared_lists, @list
        end
      end
      
      context "having 5 lists" do
        setup do
          @user.lists << @list
          4.times { @user.lists << Factory.build(:list) }
        end
        
        should "have 5 lists" do
          assert_equal 5, @user.lists.count
        end
        
        should "contain first list" do
          assert_contains @user.lists, @list
        end
      end
      
      context "having other user's list" do
        setup do
          @other_user = Factory(:user)
          @other_user.lists << @list
          @user.lists << @list
        end
        
        should "contain other user's list" do
          assert_contains @user.lists, @list
        end
        
        should "not contain other user's list in owned lists" do
          assert_does_not_contain @user.owned_lists, @list
        end
        
        should "contain other user's list in shared lists" do
          assert_contains @user.shared_lists, @list
        end
      end
      
      context "for owned lists" do
        setup do
          @user.lists << @list
        end
        
        should "have one owned list" do
          assert_equal 1, @user.owned_lists.count
        end
        
        should "contain the list" do
          assert_contains @user.owned_lists, @list
        end
        
        context "having 2 lists" do
          setup do
            @other_list = Factory.build(:list)
            @user.lists << @other_list
          end
          
          should "have two owned lists" do
            assert_equal 2, @user.owned_lists.count
          end
          
          should "contain second list" do
            assert_contains @user.owned_lists, @other_list
          end
        end
      end
      
      context "for shared lists" do
        setup do
          @other_user = Factory(:user)
          @other_user.lists << @list
          @user.lists << @list
        end
        
        should "have one shared list" do
          assert_equal 1, @user.shared_lists.count
        end
        
        should "contain the list" do
          assert_contains @user.shared_lists, @list
        end
        
        context "having 2 lists" do
          setup do
            @other_list = Factory.build(:list)
            @other_user.lists << @other_list
            @user.lists << @other_list
          end
          
          should "have two shared lists" do
            assert_equal 2, @user.shared_lists.count
          end
          
          should "contain second list" do
            assert_contains @user.shared_lists, @other_list
          end
        end
      end
    end    
  end
end

# == Schema Info
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     not null, default("")
#  encrypted_password   :string(128)     not null, default("")
#  password_salt        :string(255)     not null, default("")
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  username             :string(255)
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime