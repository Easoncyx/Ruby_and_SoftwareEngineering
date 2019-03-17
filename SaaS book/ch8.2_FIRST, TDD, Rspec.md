# FIRST

Unit Tests should be FIRST

- **Fast**: run (subset of) tests quickly (since you’ll be running them *all the time*)

- **Independent**: no tests depend on others, so can run *any subset* in *any order*

- **Repeatable**: run N times, get same result (to help isolate bugs and enable automation)

- **Self-checking**: test can *automatically* detect if passed (*no human checking* of output)

- **Timely**: written about the same time as code under test (with TDD, written *first!*)



# Rspec DSL

Rspec is a Domain-Specific Language (DSL)

like regex, SQL



## RSpec Basics by Example

```ruby
x = Math.sqrt(9)
expect(x).to eq 3
expect(sqrt(9)).to be_within(.5).of(3)

expect(x.odd?).to be_true
expect(x).to be_odd
expect(hash['key']).to be_truthy

m = Movie.new(:rating => 'R')
expect(m).to be_a_kind_of Movie
```


## How to write rspec

describe to group a number of test (can be nested)
within the describe block there's a number of **examples** which begins with 'it'

use **before** in context

```ruby
require 'ruby_intro.rb'

describe "BookInStock" do
  it "should be defined" do
    expect { BookInStock }.not_to raise_error
  end

  describe 'getters and setters' do
    before(:each)  { @book = BookInStock.new('isbn1', 33.8) }
    it 'sets ISBN' do
      expect(@book.isbn).to eq('isbn1')
    end
    it 'sets price' do
      expect(@book.price).to eq(33.8)
    end
    it 'can change ISBN' do
      @book.isbn = 'isbn2'
      expect(@book.isbn).to eq('isbn2')
    end
    it 'can change price' do
      @book.price = 300.0
      expect(@book.price).to eq(300.0)
    end
  end
```

## expect with {}
test being self-checking, run the block of code and catch the exception

```ruby
expect { m.save! }.to raise_error(ActiveRecord::RecordInvalid)
m = (create a valid movie)
expect(m).to be_valid
expect { m.save! }.to change { Movie.count }.by(1)
```

change will run the code in {} twice, once before and once after to detect the change of the result


expection and matcher
[see relish link rspec expections](https://relishapp.com/rspec/rspec-expectations/docs)



```ruby
require 'dessert'
require 'debugger'

describe Dessert do
  describe 'cake' do
    subject { Dessert.new('cake', 400) }
    its(:calories) { should == 400 }
    its(:name)     { should == 'cake' }
    it { should be_delicious }
    it { should_not be_healthy }
  end
  describe 'apple' do
    subject { Dessert.new('apple', 75) }
    it { should be_delicious }
    it { should be_healthy }
  end
  describe 'can set' do
    before(:each) { @dessert = Dessert.new('xxx', 0) }
    it 'calories' do
      @dessert.calories = 80
      @dessert.calories.should == 80
    end
    it 'name' do
      @dessert.name = 'ice cream'
      @dessert.name.should == 'ice cream'
    end
  end
end

```
