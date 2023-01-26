class ClassLevel
  attr_accessor :level, :members

  def initialize(level)
    @level = level
    @members = []
  end

  def <<(student)
    if @members.include?(student)
      puts 'That student is already added'
    else
      @members << student
    end
  end

  def valedictorian
    highest_gpa_student = @members.max_by { |member| member.gpa }
    puts "#{highest_gpa_student.name} has the highest GPA of #{highest_gpa_student.gpa}"
  end
end

class Student
  attr_accessor :name, :gpa

  def initialize(name, id, gpa)
    @name = name
    @id = id
    @gpa = gpa
  end

  def id
    last_digits = @id.split('-').last
    "XXX-XX-#{last_digits}"
  end

  def to_s
    "      ===========
      Name: #{name}
      Id: #{id}
      GPA: #{gpa}
      =========="
  end

  def ==(other)
    id == other.id
  end

  def >(other)
    gpa > other.gpa
  end

  def <(other)
    gpa < other.gpa
  end
end

juniors = ClassLevel.new('Juniors')

anna_a = Student.new('Anna', '123-11-123', 3.85)
bob = Student.new('Bob', '555-44-555', 3.23)
chris = Student.new('Chris', '321-99-321', 2.98)
david = Student.new('David', '987-00-987', 3.12)
anna_b = Student.new('Anna', '543-33-543', 3.76)

juniors << anna_a
juniors << bob
juniors << chris
juniors << david
juniors << anna_b

juniors << anna_a
  # => "That student is already added"

puts juniors.members
  # => ===========
  # => Name: Anna
  # => Id: XXX-XX-123
  # => GPA: 3.85
  # => ==========
  # => ...etc (for each student)

p anna_a == anna_b
  # => false

p david > chris
  # => true

juniors.valedictorian
  # => "Anna has the highest GPA of 3.85"
