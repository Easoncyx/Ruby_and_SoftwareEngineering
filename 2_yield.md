
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
