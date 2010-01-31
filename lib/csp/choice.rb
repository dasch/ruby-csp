
module CSP

  # Read a value off one of the options.
  #
  # If more than one channel is ready, the first in the list is chosen.
  # If none are ready, the call will block until one of the channels are
  # written to.
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
