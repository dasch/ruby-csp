
require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'lib/csp'


class ChannelTest < Test::Unit::TestCase

  context "A CSP channel" do

    setup do
      @channel = CSP::Channel.new
    end

    should "send over channels" do
      p1 = CSP::Process.new { @channel.write(42) }
      p2 = CSP::Process.new { assert_equal 42, @channel.read }

      CSP.start(p2, p1)
      CSP.start(p1, p2)
    end

    should "send multiple values over channels" do
      p1 = CSP::Process.new { [1, 2, 3].each {|i| @channel.write(i) } }
      p2 = CSP::Process.new { [1, 2, 3].each {|i| assert_equal i, @channel.read } }

      CSP.start(p2, p1)
    end

    should "iterate over received values" do
      count = 0

      p1 = CSP::Process.new { @channel.each {|msg| count += 1; assert_equal 42, msg } }
      p2 = CSP::Process.new { 2.times { @channel.write(42) } }

      CSP.start(p1, p2)

      assert_equal 2, count
    end

    should "send multiple messages with the << operator" do
      p1 = CSP::Process.new { @channel << 42 << 19 }
      p2 = CSP::Process.new { [42, 19].each {|msg| assert_equal msg, @channel.read } }

      CSP.start(p1, p2)
    end

  end

end
