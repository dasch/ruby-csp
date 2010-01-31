
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = Dir.glob("test/*_test.rb")
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "csp"
    gemspec.summary = "Concurrent Sequential Processes"
    gemspec.description = "Massive concurrency with message-passing and stuff."
    gemspec.email = "daniel.schierbeck@gmail.com"
    gemspec.homepage = "http://github.com/dasch/ruby-csp"
    gemspec.authors = ["Daniel Schierbeck"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
