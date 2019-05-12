require 'test_helper'

class Home2ControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get home2_top_url
    assert_response :success
  end

end
