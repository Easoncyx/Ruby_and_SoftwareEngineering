# a = nil
# b = {'a':44}
# puts a
# puts b
# puts (a || b)



def test
  x = "World"
  yield("Hello")
  puts x
end

x = "Ruby"
result = test { |y| puts "#{y} #{x}" }
