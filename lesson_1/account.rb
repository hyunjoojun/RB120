class Account
  attr_reader :name, :balance

  def initialize(name, balance=100)
    @name = name
    @balance = balance
  end

  def display_balance(pin_number)
    if pin_number == pin
      puts "Balance: $#{@balance}."
    else
      puts pin_error
    end
  end

  def withdraw(pin_number, amount)
    if pin_number == pin && amount <= @balance
      @balance -= amount
      puts "Withdrew $#{amount}. New balance: $#{@balance}."
    elsif pin_number == pin && amount > @balance
      puts 'Not enough balance.'
    else
      puts pin_error
    end
  end

  def deposit(pin_number, amount)
    if pin_number == pin
      @balance += amount
      puts "Deposit $#{amount}. New balance: $#{@balance}."
    else
      puts pin_error
    end
  end

  private

  def pin
    @pin = 1234
  end

  def pin_error
    'Access denied: incorrect PIN.'
  end
end

checking_account = Account.new('Chase checking', 465.13)
puts checking_account.withdraw(1234, 46)
puts checking_account.display_balance(1234)
puts checking_account.deposit(1234, 400_000)
puts checking_account.display_balance(4533)
