require 'test_helper'

class ManagementControllerTest < ActionController::TestCase
  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get major" do
    get :major
    assert_response :success
  end

  test "should get message" do
    get :message
    assert_response :success
  end

end
