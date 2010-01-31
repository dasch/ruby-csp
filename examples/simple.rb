
$:.unshift(File.dirname(__FILE__) + "/../lib/")
require 'csp'

# Prints "Hello, World!" to stdout.
chan = CSP::Channel.new
CSP::Process.new { puts(chan.read) }.start
CSP::Process.new { chan << "Hello, World!" }.start
