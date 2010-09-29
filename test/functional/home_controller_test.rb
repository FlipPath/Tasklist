require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  context "home controller" do
    context "for index action" do
      setup { get(:index) }
      
      # should assign_to(:users).with_kind_of("String")
      
      should respond_with(:success)
      
      should render_template(:index)
    end
  end
end
