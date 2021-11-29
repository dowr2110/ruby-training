class Coffee
  def cost
    5
  end
end

class Decorator < Coffee
  attr_accessor :component

  def initialize(component)
    @component = component
  end


end

class AddSugarDecorator < Decorator
  def cost
    @component.cost + 3
  end
end

class AddMilkDecorator < Decorator
  def cost
    @component.cost + 5
  end
end

# def client_code(component)
#   # ...
#
#   print "RESULT: #{component.operation}"
#
#   # ...
# end

puts ' It is cost of coffee before decorator :'
coffee = Coffee.new
puts coffee.cost

puts ' It is cost of coffee after Adding Sugar (decorator) :'
coffeeWithSugar= AddSugarDecorator.new(coffee)
puts coffeeWithSugar.cost

puts ' It is cost of sugar coffee after Adding Milk (decorator) :'
coffeeWithSugarAndMilk = AddMilkDecorator.new(coffeeWithSugar)
puts coffeeWithSugarAndMilk.cost
