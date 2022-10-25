class Student
  attr_accessor :name, :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new('Joe', 90)
bob = Student.new('Bob', 84)
puts "Well done!" if joe.better_grade_than?(bob)


class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def public_hi
    hi
  end

  private

  def hi
    "hi"
  end
end

bob = Person.new('Steve')
puts bob.public_hi
