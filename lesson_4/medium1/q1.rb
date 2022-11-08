class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

bank1 = BankAccount.new(4500)
puts bank1.positive_balance?

# Ben is right because we have attr_reader for @balance variable.
# We don't need @ becuase the getter method will return value of @balance.
