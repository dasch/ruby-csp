
require "csp/scheduler"
require "csp/channel"
require "csp/process"
require "csp/choice"
require "csp/skip"
require "csp/stdio"

module CSP

  class << self

    def start(*processes)
      processes.each do |process|
        process.start
      end

      CSP.run
    end

    # Yield execution to another process.
    def yield
      scheduler.yield
    end

    def run
      scheduler.run
    end

    def enqueue(cont)
      scheduler.enqueue(cont)
    end

    private

    def scheduler
      @scheduler ||= CSP::Scheduler.new
    end

  end

end
