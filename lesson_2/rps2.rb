# frozen_string_literal: true

class Game
  attr_reader :rounds, :player_1, :player_2

  def initialize
    @current_round = 1
    @rounds = []
    @player_1 = ComputerPlayer.new
    @player_2 = HumanPlayer.new
  end

  def start
    while @current_round < 6
      # Start a new round
      round = Round.new(@player_1, @player_2)
      round.start
      @rounds << round

      @current_round += 1
    end
  end
end

class Score
  def initialize(rounds)
    @rounds = rounds
    @formatted_rounds = Hash.new { |k, v| k[v] = 0 }.tap do |h|
      rounds.each do |round|
        h[round.winner] += 1
      end
    end
  end

  def format
    @formatted_rounds.each do |k, v|
      puts "#{k.name}: #{v}"
    end
  end
end

class Round
  attr_reader :winner, :player_1, :player_2, :winning_hands

  def initialize(player_1, player_2)
    @winner = nil
    @player_1 = player_1
    @player_2 = player_2
    @winning_hands = {}
  end

  def start
    while @winner.nil?
      # Player 1 and Player 2 keep shooting until someone wins
      player_1_choice = @player_1.choice
      player_2_choice = @player_2.choice

      if player_1_choice.beats?(player_2_choice)
        @winner = @player_1
        @winning_hands = { player_1: player_1_choice, player_2: player_2_choice }
      elsif player_2_choice.beats?(player_1_choice)
        @winner = @player_2
        @winning_hands = { player_1: player_1_choice, player_2: player_2_choice }
      end
    end
  end
end

class Choice
  attr_reader :selection

  def initialize
    @selection = %w[Rock Paper Scissors].sample
  end

  def beats?(other_choice)
    case @selection
    when "Rock"
      other_choice.selection == "Scissors"
    when "Paper"
      other_choice.selection == "Rock"
    when "Scissors"
      other_choice.selection == "Paper"
    else
      false
    end
  end
end

class HumanPlayer
  attr_reader :name

  def initialize
    ask_user_for_name
  end

  def ask_user_for_name
    print "Please enter your name: "
    @name = gets.chomp
  end

  def choice
    Choice.new
  end
end

class ComputerPlayer
  attr_reader :name

  def initialize
    @name = %w[Steve Brian Hajin James David].sample
  end

  def choice
    Choice.new
  end
end
