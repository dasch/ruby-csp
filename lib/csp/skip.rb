
module CSP

  class SKIP

    class << self

      def read(options = {})
        options[:callback] && options[:callback].call
      end

    end

  end

end
