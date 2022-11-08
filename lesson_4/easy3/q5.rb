class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # undefined method error
tv.model

Television.manufacturer
Television.model # no method error
