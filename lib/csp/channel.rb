
module CSP

  class Channel

    include Enumerable

    def initialize
      @readers = []
      @writers = []
    end

    def read(options = {})
      message = callcc do |cont|
        @readers << cont

        if @writers.empty?
          if options[:callback]
            return
          else
            CSP.run
          end
        else
          @writers.shift.call
        end
      end

      if options[:callback]
        options[:callback].call(message)
      else
        return message
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

    def each
      yield read while true
    end

  end

end
