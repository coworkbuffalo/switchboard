require 'test_helper'

class KnockTest < ActiveSupport::TestCase
  test "unlock if includes tag" do
    assert Knock.new("#unlock").unlock?
  end

  test "not unlocked without correct tag" do
    assert ! Knock.new("#lock").unlock?
  end

  test "lock if includes tag" do
    assert Knock.new("#lock").lock?
  end

  test "not locked without correct tag" do
    assert ! Knock.new("#unlock").lock?
  end
end
