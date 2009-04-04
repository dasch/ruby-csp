

require 'lib/csp/scheduler'

module CSP

  class Channel

    include Enumerable

    def initialize
      @readers = []
      @writers = []
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
        @readers.shift.call(value)
      end
    end

    def read_optionally(target)
      value = callcc do |cont|
        @readers << cont

        if @writers.empty?
          return
        else
          @writers.shift.call
        end
      end

      target.call(value)
    end

    def each
      yield read while true
    end

  end

end
