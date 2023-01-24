module Attackable
  def attacks
    puts 'attacks!'
  end
end

class Barbarian
  include Attackable

  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end
end

class Monster
  include Attackable

  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end
end

conan = Barbarian.new("Conan", 50)
zombie = Monster.new("Fred", 100)

conan.attacks
zombie.attacks
