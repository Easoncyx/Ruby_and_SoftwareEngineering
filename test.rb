# a = nil
# b = {'a':44}
# puts a
# puts b
# puts (a || b)



# def test
#   x = "World"
#   yield("Hello")
#   puts x
# end
#
# x = "Ruby"
# result = test { |y| puts "#{y} #{x}" }

x = ['apple','cherry','apple','banana']
x.map do |fruit|
    fruit.reverse
end.sort
#  => ["ananab", "elppa", "elppa", "yrrehc"]
# > x
# => ["apple", "cherry", "apple", "banana"]

x.each do |fruit|
    puts fruit.reverse
    puts fruit
end.sort
# elppa
# apple
# yrrehc
# cherry
# elppa
# apple
# ananab
# banana
# => ["apple", "apple", "banana", "cherry"]


 x.each do |fruit|
     fruit.reverse!
 end.sort
# => ["ananab", "elppa", "elppa", "yrrehc"]
#  > x
# => ["elppa", "yrrehc", "elppa", "ananab"]
