require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  setup do
    Pusher.app_id = '20'
    Pusher.key    = '12345678900000001'
    Pusher.secret = '12345678900000001'
    Pusher.host = 'api.pusherapp.com'
    Pusher.port = 80
  end
      
  teardown do
    Pusher.app_id = nil
    Pusher.key = nil
    Pusher.secret = nil
  end
  
  context "lists controller" do
    setup do
      @user = Factory(:user)
      sign_in @user
      @list = Factory(:list_with_ten_items)
      @user.lists << @list
    end
    
    context "for index action" do
      setup { get(:index) }
      should assign_to(:lists)
      should respond_with(:success)
      should render_template(:index)
    end
    
    context "for create action" do
      setup { post(:create, :format => :js, :list => { :name => "Groceries" }) }
      
      should assign_to(:list).with_kind_of(List)
      
      should render_template(:create)
    end
    
    context "for destroy action" do
      setup { Pusher::Channel.any_instance.expects(:trigger_async).returns(true) }
      setup { delete(:destroy, :format => :js, :id => @list.id) }
      
      should assign_to(:list).with_kind_of(List)
      
      should render_template(:destroy)
    end
  end
end
