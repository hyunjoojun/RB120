class RPSGame
  attr_accessor :human, :computer, :rounds

  MAX_SCORE = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = []
  end

  def display_welcome_message
    puts "Hello #{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "You will be playing against #{computer.name}."
    puts "The first one to score #{MAX_SCORE} will be the grand winner."
    puts "Detailed rules can be found here: http://www.samkass.com/theories/RPSSL.html"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_grand_winner
    if human.score > computer.score
      puts "\n *** The grand winner is #{human.name}! ***"
    else
      puts "\n *** The grand winner is #{computer.name}! ***"
    end
    puts ' '
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def display_game_history
    puts "Game history..."
    @rounds.each_with_index do |round, idx|
      puts "Round #{idx + 1}: #{human.name} threw #{round.human_move},
          #{computer.name} threw #{round.computer_move}"
    end
  end

  def game_over?
    human.score == MAX_SCORE || computer.score == MAX_SCORE
  end

  def play
    display_welcome_message
    loop do
      until game_over?
        round = Round.new(@human, @computer)
        round.start
        @rounds << round
      end
      display_grand_winner
      display_game_history
      reset_score
      break unless play_again?
    end
    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    system 'clear'
    answer.downcase == 'y'
  end
end

class Round
  attr_reader :human, :computer, :human_move, :computer_move

  # rock = 0, paper = 1, scissors = 2, lizard = 3, spock = 4
  WIN_MATRIX = [
    %w(tie paper rock rock spock),
    %w(paper tie scissors lizard paper),
    %w(rock scissors tie scissors spock),
    %w(rock lizard scissors tie lizard),
    %w(spock paper spock lizard tie)
  ]

  def initialize(human, computer)
    @human = human
    @computer = computer
    @winning_hand = nil
    @human_move = nil
    @computer_move = nil
  end

  def store_moves
    @human_move = human.move.value
    @computer_move = computer.move.value
  end

  def determine_winning_hand
    row = Move::VALUES.index(human_move)
    column = Move::VALUES.index(computer_move)
    @winning_hand = WIN_MATRIX[row][column]
  end

  def calculate_score
    if human_move == @winning_hand
      human.score += 1
    elsif computer_move == @winning_hand
      computer.score += 1
    end
  end

  def display_scores
    puts "---- Score Board ----"
    puts "#{human.name} : #{human.score}, #{computer.name} : #{computer.score}"
    puts "---------------------"
  end

  def display_moves
    puts "#{human.name} chose #{human_move}."
    puts "#{computer.name} chose #{computer_move}."
  end

  def display_winner
    if human_move == @winning_hand
      puts "#{human.name} won!"
    elsif computer_move == @winning_hand
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def start
    human.choose
    computer.choose
    store_moves
    system 'clear'
    display_moves
    determine_winning_hand
    display_winner
    calculate_score
    display_scores
  end
end

class Move
  attr_accessor :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  SHORTCUTS = ['r', 'p', 's', 'l', 'k']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp.strip
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n.capitalize
  end

  def choose
    choice = nil
    loop do
      puts "Please choose one:
      rock(r), paper(p), scissors(s), lizard(l), spock(k):"
      choice = gets.chomp.downcase
      break if Move::SHORTCUTS.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(Move::VALUES[Move::SHORTCUTS.index(choice)])
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

system 'clear'
RPSGame.new.play
