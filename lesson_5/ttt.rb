require 'pry'

module Displayable
  def clear
    system 'clear'
  end

  def empty_line
    puts ''
  end

  def joinor(arr, delimiter=', ', word='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first.to_s
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(delimiter)
    end
  end

  def continue
    puts "Press enter to continue\r"
    gets
  end

  def display_play_again_message
    puts "Let's play again!"
    empty_line
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end
end

class Board
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

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_identical_markers?(squares)
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    !unmarked?
  end
end

class Player
  attr_accessor :score, :name, :marker

  def initialize
    @score = 0
  end
end

class Human < Player
  include Displayable

  def initialize
    super
    ask_user_for_name
    ask_user_to_choose_marker
  end

  def choose_move(board)
    puts "Choose a square between (#{joinor(board.unmarked_keys)}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)

      puts "Sorry, that's not a valid choice."
    end
    square
  end

  private

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
      puts "Please choose your marker: (Any marker except O)"
      marker_choice = gets.chomp.strip.upcase
      break if marker_choice.size == 1 && marker_choice != 'O'
      puts "Sorry, it has to be one letter long."
    end
    self.marker = marker_choice
  end
end

class Computer < Player
  COMPUTER_MARKER = 'O'

  def initialize
    super
    @name = ['T-1000', 'Oreo', 'Wall-E', 'K9', 'BoyBot'].sample
    @marker = COMPUTER_MARKER
  end

  def choose_move(board)
    board.unmarked_keys.sample
  end
end

class Round
  include Displayable
  attr_accessor :board, :human, :computer, :current_marker

  def initialize(human, computer, current_marker)
    @board = Board.new
    @human = human
    @computer = computer
    @current_marker = current_marker
  end

  def start
    display_board
    player_move
    display_result
    update_score
    display_score
    continue
    reset
  end

  private

  def display_board
    puts "#{human.name}: #{human.marker}, #{computer.name}: #{computer.marker}"
    empty_line
    board.draw
    empty_line
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_score
    puts '- - Score Board - -'
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
    puts '- - - - - - - - - -'
  end

  def human_moves
    position = human.choose_move(board)

    board[position] = human.marker
  end

  def computer_moves
    position = computer.choose_move(board)

    board[position] = computer.marker
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def reset
    board.reset
    clear
  end

  def clear_screen_and_display_board
    clear
    display_board
  end
end

class TTTGame
  include Displayable
  MAX_SCORE = 2
  attr_accessor :human, :computer, :current_marker

  def initialize
    clear
    @human = Human.new
    @computer = Computer.new
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      ask_user_for_turn
      start_round until game_over?
      display_grand_winner
      reset_score
      break unless play_again?
      display_play_again_message
    end
  end

  def who_goes_first(user_answer)
    @current_marker = if user_answer == 'y'
                        human.marker
                      else
                        computer.marker
                      end
  end

  def start_round
    round = Round.new(@human, @computer, @current_marker)
    round.start
  end

  def game_over?
    human.score == MAX_SCORE || computer.score == MAX_SCORE
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def display_grand_winner
    if human.score > computer.score
      puts "\n *** The grand winner is #{human.name}! ***"
    else
      puts "\n *** The grand winner is #{computer.name}! ***"
    end
  end

  def ask_user_for_turn
    answer = ''
    loop do
      puts "Do you want to go first? (y or n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must enter y or n."
    end
    who_goes_first(answer)
  end

  def display_welcome_message
    puts "Hello #{human.name}! Welcome to Tic Tac Toe!
    \n => You will be playing against #{computer.name}.
    First player to win #{MAX_SCORE} rounds wins the game!"
    empty_line
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)

      puts 'Sorry, must be y or n'
    end
    answer == 'y'
  end
end

game = TTTGame.new
game.play
