module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(type, year, color, model)
    @type = type
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas pedal and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def to_s
    "My #{@type} is a #{color} #{year} #{model}!"
  end

  def age
    "Your #{model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year.to_i
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

my_car = MyCar.new('Car', '2016', 'white', 'Honda Accord')
my_truck = MyTruck.new('Truck', '2019', 'black', 'Nissan Frontier')
puts my_car.age
puts my_car