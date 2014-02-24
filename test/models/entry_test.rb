require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test "includes valid tag" do
    assert Entry.new(body: "lock").valid?
    assert Entry.new(body: "unlock").valid?
  end

  test "invalid without tag" do
    assert Entry.new(body: "huh?").invalid?
  end

  test "knocks are downcased" do
    assert Entry.new(body: "Lock").valid?
  end

  test "knocks are stripped" do
    assert Entry.new(body: " unlock").valid?
  end

  test 'allows junk after the message' do
    assert Entry.new(body: "unlock, s'il vous plaît").valid?
  end

  test "unlock if includes tag" do
    assert Entry.new(body: "unlock").unlock?
  end

  test "not unlocked without correct tag" do
    assert ! Entry.new(body: "lock").unlock?
  end

  test "lock if includes tag" do
    assert Entry.new(body: "lock").lock?
  end

  test "not locked without correct tag" do
    assert ! Entry.new(body: "unlock").lock?
  end

  test "one letter entries are allowed" do
    RestClient.stubs(:post)

    lock = Entry.new(body: "L")
    assert lock.lock?
    lock.save
    assert_equal "lock", lock.reload[:action]

    unlock = Entry.new(body: "U")
    assert unlock.unlock?
    unlock.save
    assert_equal "unlock", unlock.reload[:action]
  end

  test "account for autocorrecting" do
    lock = Entry.new(body: "I")
    assert lock.unlock?
  end
end
