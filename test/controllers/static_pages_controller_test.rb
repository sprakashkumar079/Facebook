require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  #testing for home page only
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Connect to World With Facebook"
  end
end
