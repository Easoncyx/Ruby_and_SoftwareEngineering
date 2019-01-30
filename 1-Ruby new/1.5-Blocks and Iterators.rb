# a single line code block
# {puts "hello"}

# a multiline code block
# do
#   puts "aaa"
#   puts "bbb"
# end

#eg
def call_block
  puts "Start"
  yield
  yield
  puts "End"
end
call_block {puts "in the block"}

#eg
animals = %w( ant bee cat dog elk)
animals.each{|animals| puts animals}
animals.each{|name| print name, " "}
5.times {print "*"}
5.times {|a| print a}
3.upto(6) {|i| print i}
('a'..'e').each {|char| print char}

#eg
class Person
    def initialize( name )
         @name = name
    end

    def do_with_name
      puts "Start"
      yield( @name )
      puts "End"
    end
end

person = Person.new("Oscar")

#invoking the method passing a block
person.do_with_name do |name|
    puts "Hey, his name is #{name}"
end

#invoke the method passing a different block
person.do_with_name do |name|
    puts "Hey, his name is #{name.reverse}"
end


days = ["monday", "tuesday", "wednesday", "thursday", "friday"]
# select those which start with 't'
days.select do |item|
  item.match /^t/
end
