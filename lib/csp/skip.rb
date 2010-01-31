
module CSP

  # Represents the +NULL+ option.
  #
  # When selecting from a list of options, this object simply prevents
  # the call from blocking, e.g.
  #
  #   value = CSP.select(chan1, chan2, CSP::SKIP)
  #
  # will never block.
  #
  # @see CSP.select
  class SKIP

    class << self

      def read(options = {})
        options[:callback] && options[:callback].call
      end

    end

  end

end
