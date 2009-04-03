
require "csp/scheduler"
require "csp/channel"
require "csp/process"

module CSP

  class << self

    def scheduler
      @scheduler ||= CSP::Scheduler.new
    end

    def start(*processes)
      processes.each do |process|
        callcc do |cont|
          scheduler.enqueue(cont)
          process.start
        end
      end

      scheduler.yield
    end

    def yield
      scheduler.yield
    end

  end

end
