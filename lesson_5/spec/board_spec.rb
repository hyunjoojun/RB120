require_relative "../board.rb"
require 'pry'

RSpec.describe Board do
  describe "#[]=" do
    it "sets the marker of a specific square" do
      board = Board.new
      board[1] = 'X'

      expect(board.squares[1].marker).to eq('X')
    end
  end

  describe "#strategic_next_square" do
    context "when the human is about to win" do
      it "returns a move to block" do
        human = "X"
        computer = "O"
        board = Board.new
        board[1] = human
        board[2] = human

        board.strategic_next_square_for(computer)
      end
    end

    context "when the player is about to win" do
      it "returns a move to win" do

      end
    end
    it "returns number of the square that blocks " do
      board = Board.new
      board[1] = 'X'
      board[2] = 'X'

      expect(board.strategic_next_square('X')).to eq(3)
    end

    it "returns number of the next strategic square" do
      board = Board.new
      board[3] = 'O'
      board[7] = 'O'

      expect(board.strategic_next_square('O')).to eq(5)
    end

    it "returns number of the next strategic square" do
      board = Board.new
      board[4] = '&'
      board[5] = '&'

      expect(board.strategic_next_square('&')).to eq(6)
    end
  end
end

