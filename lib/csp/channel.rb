

require 'lib/csp/scheduler'

module CSP

  class Channel

    def initialize
      @readers = []
      @writers = []
    end

    def read
      callcc do |cont|
        @readers << cont

        if @writers.empty?
          CSP.yield
        else
          @writers.shift.call
        end
      end
    end

    def write(value)
      if @readers.empty?
        callcc do |cont|
          @writers << cont
          CSP.yield
        end
      end

      @readers.shift.call(value)
    end

  end

end
