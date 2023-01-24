class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts "#{@name} says #{self.class::SOUND}"
  end
end

class Dog < Animal
  SOUND = 'Woof Woof!'

  def initialize(name)
    super
  end
end

class Cat < Animal
  SOUND = 'Meow!'
  def initialize(name)
    super
  end
end

fido = Dog.new('Fido')
felix = Cat.new('Felix')

fido.speak
felix.speak
