

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
          CSP.run
        else
          @writers.shift.call
        end
      end

      @value
    end

    def write(value)
      if @readers.empty?
        callcc do |cont|
          @writers << cont
          CSP.run
        end
      end

      callcc do |cont|
        CSP.enqueue(cont)
        @value = value
        @readers.shift.call
      end
    end

    def read_optionally(target)
      callcc do |cont|
        @readers << cont

        if @writers.empty?
          return
        else
          @writers.shift.call
        end
      end

      target.call(@value)
    end

  end

end
