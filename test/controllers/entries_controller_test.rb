require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  test "requires token" do
    post :create, format: :xml
    assert_response :unauthorized
  end

  test "replies successfully from valid number" do
    Twilio::REST::Messages.any_instance.expects(:create)
    post :create, format: :xml, token: "deadbeef", From: "+#{members(:bill).phone_number}", Body: "unlock"
    assert_response :success
  end

  test "ignores pinging IFTTT with invalid body" do
    Twilio::REST::Messages.any_instance.expects(:create).never
    post :create, format: :xml, token: "deadbeef", From: "+#{members(:bill).phone_number}", Body: "foobar"
    assert_response :success
  end

  test "rejects from unknown number" do
    assert_raise ActiveRecord::RecordNotFound do
      post :create, format: :xml, token: "deadbeef", From: "+15558889999"
    end
  end
end
