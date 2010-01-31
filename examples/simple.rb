
$:.unshift(File.dirname(__FILE__) + "/../lib/")
require 'csp'

# Prints "Hello, World!" to stdout.
chan = CSP::Channel.new
CSP::Process.start { puts(chan.read) }
CSP::Process.start { chan << "Hello, World!" }
