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

  describe "#find_at_risk_square" do
    it "returns number of the riskiest square" do
      board = Board.new
      board[1] = 'X'
      board[2] = 'X'

      expect(board.find_at_risk_square).to eq(3)
    end
  end
end

