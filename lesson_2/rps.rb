require 'pry'

class RPSGame
  attr_accessor :human, :computer

  MAX_SCORE = 10

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hello #{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "You will be competing with #{computer.name}."
    puts "The first one to score #{MAX_SCORE} will be the grand winner."
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_grand_winner
    if human.score == MAX_SCORE
      puts "*** The grand winner is #{human.name}! ***"
    elsif computer.score == MAX_SCORE
      puts "*** The grand winner is #{computer.name}! ***"
    end
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def play
    display_welcome_message
    loop do
      until human.score == MAX_SCORE || computer.score == MAX_SCORE
        Round.new(@human, @computer).start
      end
      display_grand_winner
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
    answer.downcase == 'y'
  end
end

class Round
  attr_reader :human, :computer

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
  end

  def determine_winner
    index1 = Move::VALUES.index(human.move.value)
    index2 = Move::VALUES.index(computer.move.value)
    @winning_hand = WIN_MATRIX[index1][index2]
  end

  def calculate_score
    if human.move.value == @winning_hand
      human.score += 1
    elsif computer.move.value == @winning_hand
      computer.score += 1
    end
  end

  def display_scores
    puts "- - - Score Board - - -"
    puts "#{human.name} : #{human.score}, #{computer.name} : #{computer.score}"
  end

  def display_moves
    puts ""
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move.value == @winning_hand
      puts "#{human.name} won!"
    elsif computer.move.value == @winning_hand
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def start
    human.choose
    computer.choose
    display_moves
    determine_winner
    display_winner
    calculate_score
    display_scores
  end
end

class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

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
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
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
