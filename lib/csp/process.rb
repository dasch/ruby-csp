

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

    # Create and start a new CSP process.
    def self.start(&block)
      process = new(&block)
      process.start
      process
    end

  end

end
