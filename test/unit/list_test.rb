require 'test_helper'

class ListTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  
  context "for latest" do
    setup do
      List.destroy_all
      @first_list = Factory(:empty_list, :created_at => 1.day.ago)
      @second_list = Factory(:empty_list, :created_at => Time.now)
    end
    
    should "be order descending" do
      assert_equal [@second_list, @first_list], List.latest
    end
  end
  
end
