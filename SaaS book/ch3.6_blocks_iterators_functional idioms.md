# Map

map is going to create a new collection in which each elements  is the result of calling that anonymous lambda.

```ruby
x = ['apple','cherry','apple','banana']

x.map do |fruit|
    fruit.reverse
end.sort
#  => ["ananab", "elppa", "elppa", "yrrehc"]
# > x
# => ["apple", "cherry", "apple", "banana"]

x.each do |fruit|
    fruit.reverse!
end.sort
# => ["ananab", "elppa", "elppa", "yrrehc"]
#  > x
# => ["elppa", "yrrehc", "elppa", "ananab"]

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
```

# Collect

`x.collect { |f| f.include?("e")}`

# Any
`x.any? { |f| f.length > 5}`

# One statement example using functional programming

```ruby
require 'mechanize'

def get_clipper_value()
  # local variables
  url = 'https://clippercard.com/ClipperWeb/login.do'
  username = 'xxx@xxx.com'
  password = 'xxx'
  # notice method chaining:
  amount =
    Mechanize.new.
    # note passing of hash argument
    post(url, :username => username, :password => password).
    # not use of regular expression as hash value
    link_with(:href => /cardValue/i).
    click.
    parser.xpath("//tr/td[contains(.,'Clipper Cash')]").first.
    next_sibling.next_sibling.
    content.match(/\$(\d+\.\d+)/)
  html($1)
end

```