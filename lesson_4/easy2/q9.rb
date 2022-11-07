class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Eyes down"
  end
end

# play method in Bingo class will be called first if we created a
# new instance under Bingo class and called play method with it.
