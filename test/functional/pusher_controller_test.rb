require 'test_helper'

class PusherControllerTest < ActionController::TestCase
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
  
  context "pusher controller" do
    
    context "with unauthenticated user" do
      context "for auth action" do
        setup { post(:auth) }
        
        should respond_with(:found)
      end
    end
    
    context "with authenticated user" do
      setup do
        User.destroy_all
        @user = Factory(:user)
        sign_in @user
        @list = Factory(:list_with_tasks)
        @user.lists << @list
        
        user_data = { 
          :user_id => @user.id,
          :user_info => {
            :username => @user.username,
            :name => @user.name,
            :email => @user.email
          }
        }
        
        @channel = mock()
        @channel.stubs(:authenticate).with("abc123", user_data).returns({})
        Pusher.stubs(:[]).returns(@channel)
      end
      
      context "for auth action" do
        context "with valid private-list channel" do
          setup { post(:auth, :channel_name => "private-list-#{@list.id}", :socket_id => "abc123") }
          
          should respond_with(:success)
          
          should assign_to(:response).with_kind_of(Hash)
        end

        context "with invalid private-list channel" do
          setup { post(:auth, :channel_name => "private-list-b4df00d", :socket_id => "abc123") }

          should respond_with(:forbidden)
        end
        
        context "with valid presence-list channel" do
          setup { post(:auth, :channel_name => "presence-list-#{@list.id}", :socket_id => "abc123") }
          
          should respond_with(:success)
          
          should assign_to(:response).with_kind_of(Hash)
        end

        context "with invalid presence-list channel" do
          setup { post(:auth, :channel_name => "presence-list-b4df00d", :socket_id => "abc123") }

          should respond_with(:forbidden)
        end
      end
    end
  end
end
