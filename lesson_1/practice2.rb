class Being
  @@count = 0

  def initialize
    @@count += 1
    puts 'Being class created'
  end

  def show_count
    "There are #{@@count} beings"
  end
end

class Human < Being
  def initialize
    super
    puts 'Human is created'
  end
end

class Animal < Being
  def initialize
    super
    puts 'Animal is created'
  end
end

class Dog < Animal
  def initialize
    super
    puts 'Dog is created'
  end
end

class Person
  def initialize(name='unknown', age=0)
    @name = name
    @age = age
  end

  def get_name
    @name
  end

  def to_s
    "Name: #{@name}, Age: #{@age}"
  end
end

class Circle
  @@PI = 3.141592

  def initialize
    @radius = 0
  end

  def set_radius(radius)
    @radius = radius
  end

  def area
    @radius * @radius * @@PI
  end
end

class Some

  def initialize
    method1
    self.method1
  end

  protected

  def method1
    puts 'Public method1 called'
  end

  public

  def method2
    puts 'Public method2 called'
  end

  def method3
    puts 'Public method3 called'
    method1
    self.method1
  end
end

class Base
  def initialize
    @name = "Base"
  end

  def show(x=0, y=0)
    p "Base class, x: #{x}, y: #{y}"
  end

  private

  def private_method
    puts 'private method called'
  end

  protected

  def protected_method
    puts 'protected method called'
  end

  public

  def get_name
    return @name
  end
end

class Derived < Base
  def public_method
    private_method
    protected_method
  end

  def show(x, y)
    super
    super(x)
    super(x, y)
    super()
  end
end
