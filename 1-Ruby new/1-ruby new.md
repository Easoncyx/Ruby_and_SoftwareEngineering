# Ruby is an object oriented language
1. In Ruby, you’d deﬁne a **class** to represent each of these entities. A class is a combination of state -- **instance variable** (for example, the name of the song) and **instance methods** that use that state (perhaps a method to play the song). 

	Methods are invoked by sending a **message** to an object. The message contains the method’s name, along with any parameters the method may need. When an object receives a message, it looks into its own class for a corresponding method. If found, that method is executed.

1. Once you have these classes, you’ll typically want to create a number of **instances** of each. 

	In Ruby, these objects are created by calling a **constructor**, a special method associated with a class. The standard constructor is called **new**.
	
	```ruby
	song1 = Song.new("aaa")
	song2 = Song.new("bbb")
	```

1. invoke a method

	```ruby
	"asdf".length
	"Rick".index("c")
	-1924.abs
	```
	
	```java
	number = Math.abs(number) // Java code
	```
#Some baisc Ruby


1. Addition of string

	```ruby
	def say_goodnight(name)
	  result =  "Good Night, " + name
	  return result
	end
	
	puts say_goodnight("John-Boy")
	puts say_goodnight("Mary")
	```

1. Using expression interpolation

	```ruby
	def say_goodnight(name)
	  result =  "Good Night, #{name.capitalize}"
	  return result
	end
	puts say_goodnight("harry")
	```

1. Difference between double quote and single quote

	```ruby
	def say_goodnight(name)
	  result =  'Good Night, #{name}'
	  return result
	end
	puts say_goodnight("Harry")
	```
	
1. As a shortcut, you don’t need to supply the braces when the expression is simply a global, instance, or class variable

	```ruby
	$greeting = "hello" #global variable
	@name = "Prudence" #instance variable
	puts "#$greeting, #@name"
	```
	
1. The value returned by a Ruby method is the value of the last expression evaluated, so we can get rid of the temporary variable and the return statement altogether.

	```ruby
	# no return needed
	def say_goodnight(name)
	  result =  "Good Night, #{name}"
	end
	puts say_goodnight("Eason")
	```	
	
1. Name convention in Ruby:
	The ﬁrst characters of a name indicate how the name is used. 
	1. Local variables, method parameters, and method names should all start with a lowercase letter or with an underscore. 
	1. Global variables are preﬁxed with a dollar sign ($), and instance variables begin with an “at” sign (@). 
	2. Class variables start with two “at” signs (@@). 
	3. Finally, class names, module names, and constants must start with an uppercase letter.
	
	By convention multiword instance variables are written with underscores between the words,
	
	Multiword class names are written in MixedCase (with each word capitalized). 
	
	Method names may end with the characters ?, !, and =.
	![image1](1.png)
	

# Arrays and Hashes	

1. Ruby’s arrays and hashes are indexed collections. Both store collections of objects, accessible using a key. With arrays, the key is an integer, whereas hashes support any object as a key.
2. array literal:

	```ruby
	a = [1,'cat',3.14] #array
	puts a[0]
	a[2] = nil
	puts a
	```
	nil is also an object.

	Ruby index start at 0
1. %w in array

	```ruby
	a = [ 'ant', 'bee', 'cat', 'dog', 'elk' ]
	puts a
	b = %w{ ant bee cat dog elk }
	puts b
	```	
	a and b are same array here
1. Hash

	Change the default returning value when a Hash doesn't contain the key we ask.

	```ruby
	inst_section = {
	  'cello' => 'string',
	  'clarinet' => 'woodwind',
	  'drum' => 'percussion',
	  'oboe' => 'woodwind',
	  'trumpet' => 'brass',
	  'violin' => 'string',
	  'aaa' => 123
	}
	puts inst_section['cello']
	puts inst_section['aaa']
	puts inst_section['bbb'] # return nil
	
	histogram = Hash.new(0)
	puts histogram['key1']
	histogram['key1'] = histogram['key1'] + 1
	puts histogram['key1']
	```

# Control Structure
1. Ruby use **end** to signify the end of a body

	```ruby
	i = 0
	while i<15
	  if i > 10
	    puts "Try again"
	  elsif i == 3
	    puts "you lose"
	  else
	    puts "Enter a number"
	  end
	  i += 1
	end
	```


2. Ruby **statement modiﬁers** are a useful shortcut if the body of an if or while statement is just a single expression. Simply write the expression, followed by if or while and the condition.

	```ruby
	radiation = 4000
	
	if radiation > 3000
	  puts "Danger, Will Robinson"
	end
	
	puts "Danger, Will Robinson" if radiation > 3000
	```
	
	```ruby
	square = 2
	while square < 1000
	  square = square * square
	  puts square
	end
	
	square = 2
	square = square * square while square < 1000
	puts square
	```
