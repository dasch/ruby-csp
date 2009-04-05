

module CSP

  class Process

    def initialize(&block)
      @block = block
    end

    def call
      @block.call
    end

    def start
      callcc do |cont|
        CSP.enqueue(cont)
        @block.call
      end
    end

  end

end
