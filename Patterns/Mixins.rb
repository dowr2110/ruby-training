#Руби (в отличие от С++) не разрешает множественное наследование, заменяют его mixin’ы.
module MyModule
  GOODMOOD = "happy"
  BADMOOD = "grumpy"

  def greet
    return "I'm #{GOODMOOD}. How are you?"
  end


end

class MyClass
  include MyModule

  def sayHi
    puts( greet )
  end
end

ob = MyClass.new
ob.sayHi

