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
end
