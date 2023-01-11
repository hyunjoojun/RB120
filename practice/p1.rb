class Burger
  TYPES = %w[Whopper BigMac Baconator]

end

class Side
end

class Drink
end

class Customer
  def place_order
    @order = Order.new
    @order.choose_burger
    @order.choose_drink
  end
end

class Order
  def choose_burger(type)
    @burger = Burger.new(type)
  end

  def choose_drink(type)
    @drink = Drink.new(type)
  end

  def choose_side(type)

  end

  def calculate_total_cost

  end
end
