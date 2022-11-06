# class Person
#   @name = 'bob'

#   def get_name
#     @name
#   end
# end

# bob = Person.new
# p bob.get_name

module ElizabethanEra
  GREETINGS = ['How dost thou', 'Bless thee', 'Good morrow']

  class Person
    def self.greetings
      GREETINGS.join(', ')
    end

    def greet
      GREETINGS.sample
    end
  end
end

puts ElizabethanEra::Person.greetings # => "How dost thou, Bless thee, Good morrow"
puts ElizabethanEra::Person.new.greet # => "Bless thee" (output may vary)
