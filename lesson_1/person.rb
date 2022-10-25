class Person
  def initialize(age)
    @age = age
  end

  def older?(other_person)
    age > other_person.age
  end

  protected

  attr_reader :age
end

class Parent
  def say_hi
    p "Hi from Parent"
  end
end

class Child
  def say_hi
    p "Hi from Child"
  end

  def send
    p "send from Child..."
  end

  def instance_of?
    p "I am a fake instance"
  end
end

c = Child.new
puts c.instance_of? Child
