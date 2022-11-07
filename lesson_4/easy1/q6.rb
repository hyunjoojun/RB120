class Cube
  def initialize(volume)
    @volume = volume
  end

  def get_volume
    @volume
  end
end

big_cube = Cube.new(5000)
p big_cube.get_volume
