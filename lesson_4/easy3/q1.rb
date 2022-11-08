class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
hello.hi
# It outputs message "Hello".

# hello = Hello.new
# hello.bye
# It will raise an error because there is no bye method in Hello class nor Greeting class.

# hello = Hello.new
# hello.greet
# It raises an error becuase there is no argument(message)

hello = Hello.new
hello.greet("Goodbye")
# It outputs message "Goodbye".

Hello.hi
# It will give an error becuase there is no class method hi.
