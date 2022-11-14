class ComputerPlayer
  def initialize
    @marker = [].sample
  end

  def choose_move(board)
    marked_squares = board.all_squares_with(@marker)
    at_risk_lines = Board::WINNING_LINES.find do |line|
      (line - marked_squares).length == 1
    end
    (at_risk_line - marked_squares).first
  end
end