require_relative "../square.rb"

# RSpec.describe [class name] do
#   describe [instance method name] do
#     it [instance method description] do
#       [perform the actual test]
#     end
#   end
# end

# TDD: Red, Green, Refactor
# 1. Red: write a failing test
# 2. Green: write the code that makes the test pass
# 3. Refactor: make the code prettier

RSpec.describe Square do
  describe "#to_s" do
    it "returns the marker string" do
      square = Square.new("X")

      expect(square.to_s).to eq("X")
    end
  end

  describe "#unmarked?" do
    it "return true if the square is empty" do
      square = Square.new(' ')

      expect(square.unmarked?).to eq(true)
    end

    it "return false if the square is marked" do
      square = Square.new('O')

      expect(square.unmarked?).to eq(false)
    end
  end

  describe "#marked?" do
    it "return true if the square is marked" do
      square = Square.new('O')

      expect(square.marked?).to eq(true)
    end

    it "return false if the square is empty" do
      square = Square.new(' ')

      expect(square.marked?).to eq(false)
    end
  end
end