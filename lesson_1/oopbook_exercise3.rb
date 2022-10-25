class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('Steve')
puts bob.name
bob.name = 'Bob'
puts bob.name
