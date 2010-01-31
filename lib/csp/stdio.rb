

module CSP
  def self.stdin
    return @stdin if defined?(@stdin)

    @stdin = Channel.new

    # Start a process that reads lines from stdin.
    Process.start do
      while true
        if IO.select([$stdin])
          @stdin << $stdin.gets
        end
        CSP.yield
      end
    end

    @stdin
  end

  def self.stdout
    return @stdout if defined?(@stdout)

    @stdout = Channel.new

    Process.start do
      while true
        if IO.select(nil, [$stdout])
          $stdout.puts(@stdout.read)
        end
        CSP.yield
      end
    end

    @stdout
  end

end
