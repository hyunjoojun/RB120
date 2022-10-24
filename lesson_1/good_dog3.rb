class GoodDog
  DOG_YEARS = 7
  attr_accessor :name, :age, :height, :weight
  @@number_of_dogs = 0

  def initialize(n, a, h, w)
    self.name = n
    self.age = a * DOG_YEARS
    self.height = h
    self.weight = w
    @@number_of_dogs += 1
  end

  def change_info(n, a, h, w)
    self.name = n
    self.age = a
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  puts self
end

sparky = GoodDog.new('Sparky', 12, '14 inches', '17 lbs')
p sparky.what_is_self
