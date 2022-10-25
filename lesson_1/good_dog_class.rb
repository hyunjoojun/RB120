module Swimmable
  def swim
    "I'm swimming!"
  end
end

module Walkable
  def walk
    "I'm walking."
  end
end

module Climable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climable

  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def speak
    super + " from GoodDog class"
  end
end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
