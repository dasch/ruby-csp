
module CSP

  # Read a value off one of the options.
  #
  # If more than one channel is ready, the first in the list is chosen.
  # If none are ready, the call will block until one of the channels are
  # written to.
  #
  # If you wish to avoid blocking, add {CSP::SKIP} as the final option.
  #
  #   value = CSP.select(chan1, chan2, CSP::SKIP)
  #
  # @param [CSP::Channel] options a list of channels
  def self.select(*options)
    callcc do |cont|
      options.each do |option|
        option.read(:callback => cont)
      end
      CSP.run
    end
  end

end
