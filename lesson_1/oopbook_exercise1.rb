module Example
  def hello(text)
    puts "Hello #{text}"
  end
end

class MyClass
  include Example
end

my_obj = MyClass.new
my_obj.hello('World')

module Careers
  class Engineer
  end

  class Teacher
  end
end

first_job = Careers::Teacher.new
