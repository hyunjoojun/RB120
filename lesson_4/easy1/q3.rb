module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast

# We have a Car object that's referenced by small_car variable.
# We call go_fast method on the small_car object and this prints out the string.
# self.class inside of the instance method go_fast prints out the instance's class name.
