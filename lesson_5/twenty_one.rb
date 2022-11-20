require 'pry'

class Participant
  attr_accessor :name, :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def add_card(new_card)
    @cards << new_card
  end

  def reset_cards!
    @cards = []
  end

  def reset_scores
    @score = 0
  end

  def correct_total_for_aces(total)
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end
    total
  end

  def total
    total = 0
    cards.each do |card|
      total += if card.ace?
                 11
               elsif card.jack? || card.queen? || card.king?
                 10
               else
                 card.face.to_i
               end
    end
    correct_total_for_aces(total)
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

  def ask_user_to_hit_or_stay
    puts "Would you like to (h)it or (s)tay?"
    answer = nil
    loop do
      answer = gets.chomp.strip.downcase
      break if ['h', 's'].include?(answer)
      puts "Sorry, must enter h or s."
    end
    answer
  end

  def turn(deck)
    puts "#{name}'s turn..."

    loop do
      answer = ask_user_to_hit_or_stay
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
  FACES = %w(2 3 4 5 6 7 8 9 10 J Q K A)
  attr_reader :face, :suit

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{@face}#{@suit}"
  end

  def ace?
    face == 'A'
  end

  def king?
    face == 'K'
  end

  def queen?
    face == 'Q'
  end

  def jack?
    face == 'J'
  end
end

class Round
  attr_accessor :deck, :player, :dealer, :winner

  def initialize(player, dealer)
    @deck = Deck.new
    @player = player
    @dealer = dealer
    @winner = nil
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

  def display_winner
    if player.total > dealer.total
      puts "#{player.name} wins!"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def show_result
    puts "#{player.name} => #{player.total}"
    puts "#{dealer.name} => #{dealer.total}"
    display_winner
  end

  def reset_cards
    self.deck = Deck.new
    player.reset_cards!
    dealer.reset_cards!
  end

  def calculate_scores
    if @winner == 'Player'
      player.score += 1
    elsif @winner == 'Dealer'
      dealer.score += 1
    end
  end

  def display_scores
    puts " - - - Scores - - -"
    puts "#{player.name} : #{player.score}"
    puts "#{dealer.name} : #{dealer.score}"
  end

  def greater_total
    if player.total > dealer.total
      'Player'
    else
      'Dealer'
    end
  end

  def determine_winner
    if dealer.busted?
      @winner = 'Player'
    elsif player.busted?
      @winner = 'Dealer'
    else
      @winner = greater_total
    end
  end

  def display_round_result
    if dealer.busted? || player.busted?
      show_busted
    else
      show_result
    end
  end

  def start
    deal_cards
    show_initial_cards
    player.turn(deck)
    dealer.turn(deck) unless player.busted?
    determine_winner
    calculate_scores
    display_round_result
    display_scores
    reset_cards
  end
end

class TwentyOneGame
  attr_reader :rounds, :player, :dealer

  def initialize
    system 'clear'
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
    system 'clear'
    round = Round.new(@player, @dealer)
    round.start
    @rounds << round
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

  def start
    display_welcome_message
    loop do
      start_round
      break unless play_again?
    end
    display_goodbye_message
  end
end

game = TwentyOneGame.new
game.start
