
require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'lib/csp'


class ProcessTest < Test::Unit::TestCase

  should "create a process" do
    a = []
    p = CSP::Process.new { a << 42 }

    CSP.start(p)

    assert_equal [42], a
  end

  should "send over channels" do
    c = CSP::Channel.new

    p1 = CSP::Process.new { c.write(42) }
    p2 = CSP::Process.new { assert_equal 42, c.read }

    CSP.start(p2, p1)
    CSP.start(p1, p2)
  end

  should "send multiple values over channels" do
    a = []
    c = CSP::Channel.new

    p1 = CSP::Process.new { [1, 2, 3].each {|i| c.write(i) } }
    p2 = CSP::Process.new { 3.times { a << c.read } }

    CSP.start(p2, p1)

    assert_equal [1, 2, 3], a
  end

end
