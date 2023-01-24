class PlayerCharacter
  attr_reader :name, :hitpoints
  def initialize(name, hitpoints)
    @name = name
    @hitpoints = hitpoints
  end
end

class Barbarian < PlayerCharacter
  attr_reader :rage

  def initialize(name, hitpoints)
    super(name, hitpoints)
    @rage = true
  end
end

class Summoner < PlayerCharacter
  # all Summoners have 100 manapoints
  MANAPOINTS = 100
  attr_reader :manapoints

  def initialize(name, hitpoints)
    super(name, hitpoints)
    @manapoints = MANAPOINTS
  end
end

conan = Barbarian.new("Conan", 50)
gandolf = Summoner.new("Gandolf", 25)

p conan.rage # true
p gandolf.manapoints # => 100

p gandolf.hitpoints #25
