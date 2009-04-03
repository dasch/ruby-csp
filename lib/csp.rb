
require "csp/scheduler"
require "csp/channel"
require "csp/process"
require "csp/choice"

module CSP

  class << self

    def scheduler
      @scheduler ||= CSP::Scheduler.new
    end

    def start(*processes)
      processes.each do |process|
        callcc do |cont|
          enqueue(cont)
          process.call
        end
      end

      CSP.run
    end

    def yield
      scheduler.yield
    end

    def run
      scheduler.run
    end

    def enqueue(cont)
      scheduler.enqueue(cont)
    end

  end

end
