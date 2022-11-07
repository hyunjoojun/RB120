class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
    puts @@cats_count
  end

  def self.cats_count
    @@cats_count
  end
end

# @@cats_count increases by 1 when we create an object using Cat class.
# (instantiate new object)

Cat.new('tabby')
Cat.new('russian blue')
Cat.new('shorthair')
