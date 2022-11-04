class RPSGame
  attr_accessor :human, :computer, :rounds

  MAX_SCORE = 5

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = []
  end

  def display_welcome_message
    puts "Hello #{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!
    \n => You will be playing against #{computer.name}.
    The first one to score #{MAX_SCORE} will be the grand winner.
    Detailed rules can be found here: http://www.samkass.com/theories/RPSSL.html"
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

  # rubocop:disable Layout/LineLength
  def display_game_history
    puts "Game history..."
    @rounds.each_with_index do |round, idx|
      puts "Round #{idx + 1} => #{human.name}: #{round.human_move}, #{computer.name}: #{round.computer_move}"
      if round.winner.nil?
        puts " . . . Tied Round"
      else
        puts " . . . Winner: #{round.winner}"
      end
    end
  end
  # rubocop:enable Layout/LineLength

  def game_over?
    human.score == MAX_SCORE || computer.score == MAX_SCORE
  end

  def start_round
    round = Round.new(@human, @computer)
    round.start
    @rounds << round
  end

  def play
    display_welcome_message
    loop do
      start_round until game_over?
      display_game_history
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
    system 'clear'
    answer.downcase == 'y'
  end
end

class Round
  attr_reader :human, :computer, :human_move, :computer_move, :winner

  WIN_MATRIX = [
    %w(tie paper rock rock spock),
    %w(paper tie scissors lizard paper),
    %w(rock scissors tie scissors spock),
    %w(rock lizard scissors tie lizard),
    %w(spock paper spock lizard tie)
  ]

  MAP = %w(rock paper scissors lizard spock)

  def initialize(human, computer)
    @human = human
    @computer = computer
  end

  def determine_winning_hand
    row = MAP.index(human_move.value)
    column = MAP.index(computer_move.value)
    @winning_hand = WIN_MATRIX[row][column]
  end

  def determine_winner
    @winner = if human_move.value == @winning_hand
                human.name
              elsif computer_move.value == @winning_hand
                computer.name
              end
  end

  def calculate_score
    if @winner == human.name
      human.score += 1
    elsif @winner == computer.name
      computer.score += 1
    end
  end

  def display_scores
    puts "\n    ----- Score Board -----
    #{human.name} : #{human.score}, #{computer.name} : #{computer.score}
    -----------------------"
  end

  def display_moves
    system 'clear'
    puts "#{human.name} chose #{human_move}."
    puts "#{computer.name} chose #{computer_move}."
  end

  def display_winner
    if @winner == human.name
      puts "#{human.name} won!"
    elsif @winner == computer.name
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def start
    @human_move = human.choose
    @computer_move = computer.choose
    display_moves
    determine_winning_hand
    determine_winner
    display_winner
    calculate_score
    display_scores
  end
end

class Move
  attr_accessor :value

  CHOICES = {
    r: 'rock',
    p: 'paper',
    s: 'scissors',
    l: 'lizard',
    k: 'spock'
  }

  def initialize(value)
    @value = CHOICES[value.to_sym]
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
  end
end

class Human < Player
  def initialize
    super
    set_name
  end

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
      puts "\n => Please choose one:
      rock(r), paper(p), scissors(s), lizard(l), spock(k):"
      choice = gets.chomp.downcase
      break if Move::CHOICES.keys.include?(choice.to_sym)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class RockLovingPlayer < Player
  def choose
    Move.new(%w(r r r r r p s l k).sample)
  end
end

class ScissorsLovingPlayer < Player
  def choose
    Move.new(%w(r p s s s s s l k).sample)
  end
end

class PaperLovingPlayer < Player
  def choose
    Move.new(%w(r p p p p p s l k).sample)
  end
end

class EquallyLovingPlayer < Player
  def choose
    Move.new(Move::CHOICES.keys.sample)
  end
end

class LizardSpockOnlyPlayer < Player
  def choose
    Move.new(%w(l k).sample)
  end
end

class Computer < Player
  attr_reader :name

  PLAYER_CLASSES = {
    'R2D2': ::RockLovingPlayer,
    'Hal': ::ScissorsLovingPlayer,
    'Chappie': ::PaperLovingPlayer,
    'Sonny': ::EquallyLovingPlayer,
    'Number 5': ::LizardSpockOnlyPlayer
  }

  def initialize
    @name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    @internal_player = PLAYER_CLASSES[@name.to_sym].new
    super
  end

  def choose
    self.move = @internal_player.choose
  end
end

system 'clear'
RPSGame.new.play
