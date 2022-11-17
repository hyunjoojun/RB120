require 'pry'

class Participant
  attr_accessor :name, :cards

  def initialize
    @cards = []
    set_name
  end

  def add_card(new_card)
    @cards << new_card
  end
end

class Player < Participant
  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name.capitalize
  end
end

class Dealer < Participant
  ROBOTS = ['T-1000', 'Oreo', 'Wall-E', 'K9', 'BoyBot']

  def set_name
    self.name = ROBOTS.sample
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
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
end

class Round
  attr_reader :deck, :winner, :player, :dealer

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

  def start
    while @winner.nil?
      deal_cards
      # show_initial_cards
      # player_turn
      # dealer_turn
      # show_result
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

  def start
    display_welcome_message
    while @current_round < 6
      round = Round.new(@player, @dealer)
      round.start
      @rounds << round
      @current_round += 1
    end
    display_goodbye_message
  end
end

game = TwentyOneGame.new
game.start
