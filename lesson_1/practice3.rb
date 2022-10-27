class Car
  attr_accessor :name, :price

  def to_s
    "#{@name}: #{@price}"
  end
end

class Circle
  attr_accessor :radius

  def initialize(r)
    @radius = r
  end

  def self.info
    'This is a Circle class'
  end

  def area
    @radius * @radius * 3.141592
  end

  def +(other)
    Circle.new @radius + other.radius
  end

  def to_s
    "Circle with radius: #{@radius}"
  end
end

class Wood
  def self.info
    'This is a Wood class'
  end
end

class Brick
  attr_accessor :info
end

class Rock
end

def Rock.info
  'This is a Rock class'
end

class Animal
  def make_noise
    "Some noise."
  end

  def sleep
    puts "#{self.class.name} is sleeping."
  end
end

class Dog < Animal
  def make_noise
    'Woof!'
  end
end

class Cat < Animal
  def make_noise
    'Meow!'
  end
end

module Forest
  class Rock ; end
  class Tree ; end
  class Animal ; end
end

module Town
  class Pool ; end
  class Cinema ; end
  class Square ; end
  class Animal ; end
end

module Device
  def switch_on
    puts 'on'
  end

  def switch_off
    puts 'off'
  end
end

module Volume
  def volume_up
    puts 'volume up'
  end

  def volume_down
    puts 'volume down'
  end
end

module Pluggable
  def plug_in
    puts 'plug in'
  end

  def plug_out
    puts 'plug out'
  end
end

class CellPhone
  include Device, Volume, Pluggable

  def ring
    puts 'ringing'
  end
end

age = 17

begin
  if age < 18
    raise "Person is a minor"
  end
  puts "Entry allowed"
rescue => exception
  puts exception
  p exception
  exit 1
end
