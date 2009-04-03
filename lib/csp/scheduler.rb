
module CSP

  class Scheduler

    def initialize
      @ready = []
    end

    def enqueue(cont)
      @ready << cont
    end

    def yield
      raise RuntimeError.new("Cannot yield; ready queue is empty") if @ready.empty?
      @ready.shift.call
    end

    def run
      self.yield until @ready.empty?
    end

  end

end
