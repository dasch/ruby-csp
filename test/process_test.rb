
require 'test/strap'


class ProcessTest < Test::Unit::TestCase

  should "create a process" do
    a = []
    p = CSP::Process.new { a << 42 }

    CSP.start(p)

    assert_equal [42], a
  end

end
