
module CSP

  def self.select(*options)
    callcc do |cont|
      options.each do |option|
        option.read(:callback => cont)
      end
      CSP.run
    end
  end

end
