
module CSP

  class Scheduler

    def initialize
      @ready = []
    end

    def enqueue(cont)
      @ready << cont
    end

    def yield
      schedule until @ready.empty?
    end

    def schedule
      raise RuntimeError.new("Cannot yield; ready queue is empty") if @ready.empty?
      @ready.shift.call
    end

  end

end
