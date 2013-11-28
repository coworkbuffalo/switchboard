require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "requires token" do
    post :create, format: :xml
    assert_response :unauthorized
  end

  test "replies with token" do
    post :create, format: :xml, token:  "deadbeef"
    assert_response :success
  end
end
