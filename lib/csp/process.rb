

module CSP

  class Process

    def initialize(&block)
      @block = block
    end

    def call
      @block.call
    end

  end

end
