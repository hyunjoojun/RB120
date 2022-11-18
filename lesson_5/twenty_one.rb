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
    total = 0
    cards.each do |card|
      if card.ace?
        total += 11
      elsif card.jack? || card.queen? || card.king?
        total += 10
      else
        total += card.face.to_i
      end
    end

    # correct for Aces
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def show_hand
    puts "#{name}: #{cards.join(' + ')}"
    puts "=> Total: #{total}"
    puts ""
  end

  def hit(deck)
    add_card(deck.deal_one)
    puts "#{name} hits!"
    show_hand
  end

  def stay
    puts "#{name} stays!"
  end

  def busted?
    total > 21
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

  def turn(deck)
    puts "#{name}'s turn..."

    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = nil
      loop do
        answer = gets.chomp.strip.downcase
        break if ['h', 's'].include?(answer)
        puts "Sorry, must enter h or s."
      end

      if answer == 's'
        stay
        break
      elsif busted?
        break
      else
        hit(deck)
        break if busted?
      end
    end
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

  def turn(deck)
    puts "#{name}'s turn..."

    loop do
      if total >= 17 && !busted?
        stay
        break
      elsif busted?
        break
      else
        hit(deck)
      end
    end
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
  attr_reader :face, :suit

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{@face}#{@suit}"
  end

  def ace?
    face == 'Ace'
  end

  def king?
    face == 'King'
  end

  def queen?
    face == 'Queen'
  end

  def jack?
    face == 'Jack'
  end
end

class Round
  attr_accessor :deck, :player, :dealer

  def initialize(player, dealer)
    @deck = Deck.new
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
    puts "=> Your total now: #{player.total}"
    puts "#{dealer.name}: #{dealer.show_cards} + ?"
    puts ""
  end

  def show_busted
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins!"
    else
      puts "#{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_result
    puts "#{player.name} => #{player.total}"
    puts "#{dealer.name} => #{dealer.total}"

    if player.total > dealer.total
      puts "#{player.name} wins!"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def reset_cards
    self.deck = Deck.new
    player.reset_cards!
    dealer.reset_cards!
  end

  def game_over_or_dealer_turn
    if player.busted?
      show_busted
    else
      dealer.turn(deck)
    end
  end

  def start
    deal_cards
    show_initial_cards
    player.turn(deck)
    game_over_or_dealer_turn
    show_busted if dealer.busted?
    show_result if !player.busted? && !dealer.busted?
    reset_cards
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
    while @current_round < 2
      start_round
      @current_round += 1
    end
    display_goodbye_message
  end
end

game = TwentyOneGame.new
game.start
