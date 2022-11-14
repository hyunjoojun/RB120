require_relative "../board"

class Round
  def initialize(human, computer)
    @round_over = false
    @board = Board.new
    @human = human
    @computer = computer
  end

  def start
    until @round_over
      human_move
      @round_over = true if round_over?
      computer_move
      @round_over = true if round_over?
    end
  end

  def human_move
    position = human.choose_move

    @board[position.to_i] = human.marker
  end

  def computer_move
    position = computer.choose_move

    @board[position.to_i] = computer.marker
  end

  def round_over?
    board.full? || board.someone_won?
  end
end