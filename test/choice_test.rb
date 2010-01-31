
require 'test/strap'


class ProcessTest < Test::Unit::TestCase

  context "A choice of guards" do

    should "select between multiple channels" do
      c1 = CSP::Channel.new
      c2 = CSP::Channel.new

      p1 = CSP::Process.new { c1.write(42) while true }

      CSP.start(p1)

      assert_equal 42, CSP.select(c1, c2)
      assert_equal 42, CSP.select(c2, c1)
    end

    should "select between multiple channels with decreasing priority" do
      c1 = CSP::Channel.new
      c2 = CSP::Channel.new

      p1 = CSP::Process.new { c1.write(42) while true }
      p2 = CSP::Process.new { c2.write(19) while true }

      CSP.start(p1, p2)

      assert_equal 42, CSP.select(c1, c2)
      assert_equal 19, CSP.select(c2, c1)
    end

    should "skip if no previous guards was ready" do
      c1 = CSP::Channel.new
      c2 = CSP::Channel.new

      CSP.select(c1, c2, CSP::SKIP)

      assert true
    end

  end

end
