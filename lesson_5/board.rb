class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def find_at_risk_square
    enemy_squares = squares.select do |square_num, square|
      square.marker != 'O' && square.marked?
    end
    enemy_positions = enemy_squares.keys

    at_risk_line = WINNING_LINES.find do |line|
      (line - enemy_positions).length == 1
    end

    (at_risk_line - enemy_positions).first
  end

  # def unmarked_keys
  #   @squares.keys.select { |key| @squares[key].unmarked? }
  # end

  # # rubocop:disable Metrics/AbcSize
  # # rubocop:disable Metrics/MethodLength
  # def draw
  #   puts '     |     |'
  #   puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
  #   puts '     |     |'
  #   puts '-----+-----+-----'
  #   puts '     |     |'
  #   puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
  #   puts '     |     |'
  #   puts '-----+-----+-----'
  #   puts '     |     |'
  #   puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
  #   puts '     |     |'
  # end
  # # rubocop:enable Metrics/AbcSize
  # # rubocop:enable Metrics/MethodLength

  # def full?
  #   unmarked_keys.empty?
  # end

  # def someone_won?
  #   !!winning_marker
  # end

  # def winning_marker
  #   WINNING_LINES.each do |line|
  #     squares = @squares.values_at(*line)
  #     return squares.first.marker if three_identical_markers?(squares)
  #   end
  #   nil
  # end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  # def three_identical_markers?(squares)
  #   markers = squares.select(&:marked?).collect(&:marker)
  #   return false if markers.size != 3
  #   markers.min == markers.max
  # end
end