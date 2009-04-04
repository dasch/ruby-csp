
module CSP

  def self.select(*options)
    callcc do |cont|
      options.each do |option|
        option.read_optionally(cont)
      end
      CSP.run
    end
  end

end
