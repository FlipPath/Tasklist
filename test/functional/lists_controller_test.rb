require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  context "lists controller" do
    context "for create action" do
      setup { post(:create, :format => :js, :list => { :name => "Groceries" }) }
      
      should assign_to(:list).with_kind_of(List)
      
      should render_template(:create)
    end
  end
end
