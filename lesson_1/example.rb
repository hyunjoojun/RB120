class Box
  BOX_COMPANY = "TATA Inc"
  BOX_WEIGHT = 10

  @@count = 0

  def initialize(w, h)
    @width = w
    @height = h
    @@count += 1
  end

  def self.printCount
    puts "Box count is : #{@@count}"
  end

  def getWidth
    @width
  end

  def getHeight
    @height
  end

  private :getWidth, :getHeight

  def setWidth=(value)
    @width = value
  end

  def setHeight=(value)
    @height = value
  end

  def getArea
    getWidth * getHeight
  end

  def to_s
    "w:#{@width}, h:#{@height}"
  end
end

class BigBox < Box
  def getArea
    @area = @width * @height
    puts "Big box area is : #{@area}"
  end
end

box = Box.new(10, 20)
a = box.getArea
puts "Area of the box is : #{a}"
puts Box::BOX_COMPANY
puts "Box weight is #{Box::BOX_WEIGHT}"
