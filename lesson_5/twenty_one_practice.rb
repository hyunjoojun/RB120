require 'pry'

module Displayable
  def frame(title, texts, size)
    [" - - - - #{title} - - - - ",
     " #{texts[0]} ".center(size),
     " #{texts[1]} ".center(size),
     ' - - - - - - - - - - - - - -']
  end

  def side_by_side_cards(owner)
    cards = owner.cards
    images = cards.map(&:image)

    0.upto(4) do |line|
      row = images.map do |img|
        img[line]
      end.join("  ")
      puts row
    end
  end
end

class Participant
  include Displayable
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

  def total
    total = convert_card_to_value.sum
    correct_total_for_aces(total)
  end

  def show_hand
    puts "#{name}:"
    side_by_side_cards(self)
    puts "=> Total: #{total}"
    puts ""
  end

  def display_turn
    puts "#{name}'s turn..."
  end

  def hit(deck)
    add_card(deck.deal_one)
    puts "#{name} hits!"
    show_hand
  end

  def stay
    puts "#{name} stays!"
    show_hand
  end

  def busted?
    total > 21
  end

  private

  def correct_total_for_aces(total)
    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end
    total
  end

  def convert_card_to_value
    cards.map do |card|
      if card.ace?
        11
      elsif card.jack? || card.queen? || card.king?
        10
      else
        card.face.to_i
      end
    end
  end
end

class Player < Participant
  def initialize
    super
    ask_user_for_name
  end

  def turn(deck)
    display_turn
    loop do
      answer = ask_user_to_hit_or_stay
      answer == 'h' ? hit(deck) : stay
      break if answer == 's' || busted?
    end
  end

  private

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
    cards.each(&:unhide!)
    display_turn
    until busted?
      if total >= 17 && !busted?
        stay
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

  attr_reader :hidden

  def initialize(suit, face)
    @suit = suit
    @face = face
    @hidden = false
  end

  def image
    ["+------+",
     "|    #{suit} |",
     "|      |",
     "| #{face.length > 1 ? face : face + ' '}   |",
     '+------+']
  end

  def suit
    hidden ? "?" : @suit
  end

  def face
    hidden ? "?" : @face
  end

  def hide!
    @hidden = true
  end

  def unhide!
    @hidden = false
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
  include Displayable
  attr_accessor :deck, :player, :dealer, :winner

  def initialize(player, dealer)
    @deck = Deck.new
    @player = player
    @dealer = dealer
  end

  def start
    main_game
    determine_winner
    calculate_scores
    display_round_result
    display_scores
    reset_cards
  end

  def display_scores
    scores = ["#{player.name} : #{player.score}",
              "#{dealer.name} : #{dealer.score}"]
    puts frame('Score Board', scores, 28)
  end

  def dealer_initial_card
    dealer.cards[1].hide!
    puts "#{dealer.name}:"
    side_by_side_cards(dealer)
    puts ""
  end

  def show_initial_cards
    puts "#{player.name}:"
    side_by_side_cards(player)
    puts "=> Your total now: #{player.total}"
    dealer_initial_card
  end

  private

  def main_game
    deal_cards
    show_initial_cards
    player.turn(deck)
    dealer.turn(deck) unless player.busted?
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
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
    if @winner == player.name
      player.score += 1
    elsif @winner == dealer.name
      dealer.score += 1
    end
  end

  def greater_total
    if player.total > dealer.total
      player.name
    else
      dealer.name
    end
  end

  def determine_winner
    @winner = if dealer.busted?
                player.name
              elsif player.busted?
                dealer.name
              else
                greater_total
              end
  end

  def display_round_result
    if dealer.busted? || player.busted?
      show_busted
    else
      show_result
    end
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

  def start
    display_welcome_message
    loop do
      start_round
      break unless play_again?
    end
    display_final_scores
    display_goodbye_message
  end

  private

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

  def display_final_scores
    system 'clear'
    rounds.last.display_scores
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

game = TwentyOneGame.new
game.start
