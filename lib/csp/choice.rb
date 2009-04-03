
module CSP

  def self.select(*options)
    value = callcc do |cont|
      options.each do |option|
        option.read_optionally(cont)
      end
      CSP.run
    end

    raise RuntimeError.new("Deadlocked") if value.nil?

    return value
  end

end
