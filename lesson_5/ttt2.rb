class Board
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def get_square_at(key)
    @squares[key]
  end
end

class Square
  INITIAL_MARKER = ' '

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class HumanPlayer
  attr_accessor :score, :name, :marker

  def initialize
    ask_user_for_name
    ask_user_to_choose_marker
    @score = 0
  end

  def ask_user_for_name
    player_name = ''
    loop do
      puts "What's your name?"
      player_name = gets.chomp.strip
      break unless player_name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = player_name.capitalize
  end

  def ask_user_to_choose_marker
    marker_choice = ''
    loop do
      puts "Please choose your marker: O or X"
      marker_choice = gets.chomp.strip.upcase
      break if %w(O X).include? marker_choice
      puts "Sorry, must be O or X."
    end
    self.marker = marker_choice
  end
end

class ComputerPlayer < Player
  def initialize
    @score = 0
    @name = ['T-1000', 'Oreo', 'Wall-E', 'K9', 'BoyBot'].sample
    @marker = choose_marker
  end

  def choose_marker
    self.marker = human.marker == 'O' ? 'X' : 'O'
  end
end

class TTTGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def display_welcome_message
    puts "Welcome!"
  end

  def display_goodbye_message
    puts "Thanks. Goodbye!"
  end

  def display_board
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def play
    display_welcome_message
    loop do
      display_board
      break
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    # display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
