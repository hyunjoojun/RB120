class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Bulldog
  def jump
    puts 'Bulldog is Jumping'
  end
end

class Cat
  def jump
    puts 'Cat is jumping'
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

bob.pets.map do |pet|
  pet.jump
end
