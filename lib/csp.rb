
require "csp/scheduler"
require "csp/channel"
require "csp/process"

module CSP

  class << self

    def scheduler
      @scheduler ||= CSP::Scheduler.new
    end

    def start(*processes)
      processes.each {|process| scheduler.enqueue(process) }
      CSP.yield
    end

    def yield
      scheduler.yield
    end

  end

end
