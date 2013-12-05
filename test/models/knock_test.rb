require 'test_helper'

class KnockTest < ActiveSupport::TestCase
  test "unlock if includes tag" do
    assert Knock.new("unlock").unlock?
  end

  test "not unlocked without correct tag" do
    assert ! Knock.new("lock").unlock?
  end

  test "lock if includes tag" do
    assert Knock.new("lock").lock?
  end

  test "not locked without correct tag" do
    assert ! Knock.new("unlock").lock?
  end

  test "includes valid tag" do
    assert Knock.new("lock").valid?
    assert Knock.new("unlock").valid?
  end

  test "invalid without tag" do
    assert ! Knock.new("huh?").valid?
  end

  test "knocks are downcased" do
    assert Knock.new("Lock").valid?
  end

  test "knocks are stripped" do
    assert Knock.new(" unlock").valid?
  end
end
