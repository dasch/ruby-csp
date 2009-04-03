

module CSP

  class Process

    def initialize(&block)
      @block = block
    end

    def start
      @block.call
    end

  end

end
