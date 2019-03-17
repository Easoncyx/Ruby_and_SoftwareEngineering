a1 = 0xa
puts a1


puts 'escape using "\\"';
puts 'That\'s right';

name="Ruby"
puts name
puts "#{name+",ok"}"

# array
ary = [ "fred", 10, 3.14, "This is a string", "last element", ]
ary << 333
ary.each do |i|
    puts i
end

# hash
hsh = colors = { "red" => 0xf00, "green" => 0x0f0, "blue" => 0x00f }
hsh.each do |key, value|
    print key, " is ", value, "\n"
end
