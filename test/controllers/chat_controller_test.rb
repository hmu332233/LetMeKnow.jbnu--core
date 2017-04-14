require 'test_helper'

class ChatControllerTest < ActionController::TestCase
  test "should get keyboard" do
    get :keyboard
    assert_response :success
  end

  test "should get message" do
    get :message
    assert_response :success
  end

  test "should get add_friend" do
    get :add_friend
    assert_response :success
  end

  test "should get delete_friend" do
    get :delete_friend
    assert_response :success
  end

  test "should get chat_room" do
    get :chat_room
    assert_response :success
  end

end
