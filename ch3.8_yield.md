
Example of using yield to turn iterators inside-out
```ruby
class RandomSequence
  def initialize(limit,num)
    @limit,@num = limit,num
  end
  def each
    @num.times { yield (rand * @limit).floor }
  end
end

i = -1
RandomSequence.new(10,4).each do |num|
    i = num if i < num
end
```



```ruby
def test
  x = "World"
  yield("Hello")
  puts x
end

x = "Ruby"
result = test { |y| puts "#{y} #{x}" }
```
This give us
```
Hello Ruby
World
```
