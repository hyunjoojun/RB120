# GOAL:
# Create an application that allows you to add "products" to a shopping basket.
# So define the CLASSES for each product (make 3).
# Products should have a name and a price (an integer).
# Add products to the shopping basket
# At checkout calculate total_price of ALL products.

class ShoppingBasket
  attr_reader :products

  def initialize
    @products = []
  end

  def add(product)
    @products << product
  end
end

class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class Apple < Product
end

class Milk < Product
end

class Cheese < Product
end

class CheckoutDesk
  def calculate_total_price(basket)
    prices = basket.products.map do |product|
      product.price
    end
    prices.sum
  end
end

shopping_basket = ShoppingBasket.new
apple = Apple.new('apple', 3)
milk = Milk.new('milk', 6)
cheese = Cheese.new('cheese', 9)
shopping_basket.add(apple)
shopping_basket.add(milk)
shopping_basket.add(cheese)
p CheckoutDesk.new.calculate_total_price(shopping_basket)