require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  context "lists controller" do
    setup do
      @user = Factory(:user)
      sign_in @user
      @list = Factory(:list_with_tasks)
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
      setup { delete(:destroy, :format => :js, :id => @list.id) }
      
      should assign_to(:list).with_kind_of(List)
      
      should render_template(:destroy)
    end
  end
end
