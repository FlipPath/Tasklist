require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  context "users controller" do
    setup do
      User.destroy_all
      @user = Factory(:user)
      sign_in @user
    end
    
    context "for show action" do
      setup { get(:show, :id => @user.to_param) }
      
      should respond_with(:success)
      
      should assign_to(:user).with_kind_of(User)
    end
  end
end
