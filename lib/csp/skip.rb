
module CSP

  class SKIP

    class << self

      def read_optionally(cont)
        cont.call
      end

    end

  end

end
