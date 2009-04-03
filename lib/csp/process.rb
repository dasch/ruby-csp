

module CSP

  class Process

    def initialize(&block)
      @block = block
    end

    def start
      @block.call
    end

    alias_method :call, :start

  end

end
