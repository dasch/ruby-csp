
require 'benchmark'

$:.unshift(File.dirname(__FILE__) + "/../lib/")

require 'csp'


# Number of processes.
N = 1000

# Number of iterations.
M = 10

channels = (0...N).map { CSP::Channel.new }
processes = (0...N).map do |i|
  CSP::Process.start do
    channels[(N + i - 1) % N].each do |value|
      channels[(i + 1) % N] << value
    end
  end
end

Benchmark.bmbm do |bm|
  bm.report("Sending a value #{M} times around a #{N}-length ring") do
    channels[0] << 42
  end
end
