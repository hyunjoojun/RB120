class Person
  @@people_count = 0

  def initialize(name)
    @name = name
    @@people_count += 1
  end

  def self.number_of_people
    @@people_count
  end
end

jane = Person.new('Jane')
david = Person.new('David')

puts Person.number_of_people