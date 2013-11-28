require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "requires token" do
    post :create, format: :xml
    assert_response :unauthorized
  end

  test "replies successfully from valid number" do
    post :create, format: :xml, token: "deadbeef", From: "+#{members(:bill).phone_number}", Body: "#unlock"
    assert_response :success
  end

  test "rejects from unknown number" do
    assert_raise ActiveRecord::RecordNotFound do
      post :create, format: :xml, token: "deadbeef", From: "+15558889999"
    end
  end
end
