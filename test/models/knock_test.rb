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

  test "toggle if includes tag" do
    assert Knock.new("toggle").toggle?
  end

  test "not toggle without correct tag" do
    assert ! Knock.new("unlock").toggle?
  end

  test "includes valid tag" do
    assert Knock.new("lock").valid?
    assert Knock.new("unlock").valid?
    assert Knock.new("toggle").valid?
  end

  test "invalid without tag" do
    assert ! Knock.new("huh?").valid?
  end

  test "knocks are downcased" do
    assert Knock.new("Lock").valid?
  end
end
