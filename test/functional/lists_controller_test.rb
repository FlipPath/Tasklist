require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  context "lists controller" do
    setup { @list = Factory(:valid_list) }
    
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
