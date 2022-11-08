class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

matt = AngryCat.new(5, 'Matt')
coco = AngryCat.new(7, 'Coco')
