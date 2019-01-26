def say_goodnight(name)
  result =  "Good Night, " + name
  return result
end

puts say_goodnight("John-Boy")
puts say_goodnight("Mary")


def say_goodnight(name)
  result =  "Good Night, #{name.capitalize}"
  return result
end
puts say_goodnight("harry")


def say_goodnight(name)
  result =  'Good Night, #{name}'
  return result
end
puts say_goodnight("Harry")

$greeting = "hello" #global variable
@name = "Prudence" #instance variable
puts "#$greeting, #@name"

# no return needed
def say_goodnight(name)
  result =  "Good Night, #{name}"
end
puts say_goodnight("Eason")
