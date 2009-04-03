

require 'lib/csp/scheduler'

module CSP

  class Channel

    def initialize
      @readers = []
      @writers = []
      @value = nil
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

      return @value
    end

    def write(value)
      if @readers.empty?
        callcc do |cont|
          @writers << cont
          CSP.yield
        end
      end

      @value = value
      @readers.shift.call
    end

  end

end
