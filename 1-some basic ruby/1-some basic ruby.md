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
	