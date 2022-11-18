require 'pry'

class Participant
  attr_accessor :name, :cards

  def initialize
    @cards = []
  end

  def add_card(new_card)
    @cards << new_card
  end

  def reset_cards!
    @cards = []
  end

  def total
    # calculating deck sum
  end

  def hit

  end

  def stay

  end

  def busted?

  end
end

class Player < Participant
  def initialize
    super
    ask_user_for_name
  end

  def ask_user_for_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name.capitalize
  end

  def turn
    # ask player hit or stay
  end
end

class Dealer < Participant
  ROBOTS = ['T-1000', 'Oreo', 'Wall-E', 'K9', 'BoyBot']

  def initialize
    super
    @name = ROBOTS.sample
  end

  def show_cards
    cards.first
  end

  def turn
    # hit until total <= 17
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.product(Card::FACES).each do |tuple|
      suit = tuple[0]
      face = tuple[1]

      @cards << Card.new(suit, face)
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

class Card
  SUITS = %w(♥ ♦ ♣ ♠)
  FACES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{@face}#{@suit}"
  end
end

class Round
  attr_accessor :deck, :winner, :player, :dealer

  def initialize(player, dealer)
    @deck = Deck.new
    @winner = nil
    @player = player
    @dealer = dealer
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_initial_cards
    puts "#{player.name}: #{player.cards.join(' + ')}"
    puts "#{dealer.name}: #{dealer.show_cards} + ?"
  end

  def reset_cards
    self.deck = Deck.new
    player.reset_cards!
    dealer.reset_cards!
  end

  def start
    while @winner.nil?
      deal_cards
      show_initial_cards
      player.turn
      dealer.turn
      # show_result
      reset_cards
      @winner = 'Player'
    end
  end
end

class TwentyOneGame
  attr_reader :rounds, :player, :dealer

  def initialize
    @current_round = 1
    @rounds = []
    @player = Player.new
    @dealer = Dealer.new
  end

  def display_welcome_message
    puts "Hello #{player.name}! Welcome to Twenty-One!
    \n => You will be playing against #{dealer.name}."
    puts ""
  end

  def display_goodbye_message
    puts "Thank you for playing Twenty-One. Goodbye!"
  end

  def start_round
    round = Round.new(@player, @dealer)
    round.start
    @rounds << round
  end

  def start
    display_welcome_message
    while @current_round < 6
      start_round
      @current_round += 1
    end
    display_goodbye_message
  end
end

game = TwentyOneGame.new
game.start
