require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test "includes valid tag" do
    assert Entry.new(original_body: "lock").valid?
    assert Entry.new(original_body: "unlock").valid?
  end

  test "invalid without tag" do
    assert Entry.new(original_body: "huh?").invalid?
  end

  test "knocks are downcased" do
    assert Entry.new(original_body: "Lock").valid?
  end

  test "knocks are stripped" do
    assert Entry.new(original_body: " unlock").valid?
  end

  test "unlock if includes tag" do
    assert Entry.new(formatted_body: "unlock").unlock?
  end

  test "not unlocked without correct tag" do
    assert ! Entry.new(formatted_body: "lock").unlock?
  end

  test "lock if includes tag" do
    assert Entry.new(formatted_body: "lock").lock?
  end

  test "not locked without correct tag" do
    assert ! Entry.new(formatted_body: "unlock").lock?
  end
end
