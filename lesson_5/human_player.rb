class HumanPlayer
  def initialize(marker)
    @marker = marker
  end

  def choose_move
    position = ""

    while position.empty? do
      print "Where to place: "
      position = gets.chomp
    end

    position
  end
end