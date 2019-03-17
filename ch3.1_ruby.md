# Naming Convention
# Method
Everything (except fixnums) is pass-by-reference

Fixnum – integer values small enough to fit into a machine word, always passed by value

```ruby
def foo(x,y)
    return [x,y+1]
end
def foo(x,y=0)  # y is optional, 0 if omitted
    [x,y+1]     # last exp returned as result
end
def foo(x,y=0)
    [x,y+1]
end
```

# Symbol and String
## What is string?
A string is a list of characters in a specific sequence. Strings are surrounded by either single quotes 'hi' or double quotes "hi". A string is an instance of String class and two strings with the same contents are two different objects.

```ruby
"apple".object_id
 # => 70280408292320
"apple".object_id
 # => 70280408286140

"apple".class
# => String
```

## What is symbol?
Ruby symbols are created by placing a colon : before a word. You can think of it as an immutable string. A symbol is an instance of Symbol class, and for any given name of symbol there is only one Symbol object.

```ruby
:apple.object_id
 # => 4454888

:apple.object_id
 # => 4454888

 :apple.class
 # => Symbol
```

One more difference between string and symbol is, you can mutate the value of a string, but you can’t mutate the value of a symbol(Symbol class doesn’t have any instance method to mutate the value).

## Conversion between symbol and string
Ruby has methods to convert object from symbol to string and vice versa.

```ruby
"apple".to_sym
# => :apple
:apple.to_s
# => "apple"
```

## When to use symbol
As we mentioned above, for any given name of symbol there is only one symbol object. So every time when we call the same symbol the program don’t need to create a new object again. Comparing with string, symbol does save many resources.

One of the most common timing to use symbol in Ruby is defining a hash. For example if we have the following hash, and we need to get the value of the value frequently.

```ruby
hosts = {
  'tokyo' => 'machine1',
  'singapore' => 'machine2',
  'beijing' => 'machine3',
  'taipei' => 'machine4',
  'manila' => 'machine5'
}
host["tokyo"]
#=> 'machine1'
```

If using string as key, every time we get the value from the hash, we have to create a new string object. Since in hash, the key is just a name, and we don’t intend to change it’s value. Instead of using string as the key, it is a good timing to use symbol instead.

```ruby
hosts = {
  :tokyo => 'machine1',
  :singapore => 'machine2',
  :beijing => 'machine3',
  :taipei => 'machine4',
  :manila => 'machine5'
}
```

# String
## To use string
```ruby
"string", %Q{string}, 'string', %q{string}

a=41 ; "The answer is #{a+1}"
```


## Example
Given a string `s = "Hello: I'm a l33t programmer!!"` what single line of Ruby will produce the array`["Hello", "m", "a", "l", "t", "programmer"]`

```ruby
s.split(/[^a-zA-Z]/).reject{|e| e == "I" || e.empty?}
s.split(/[^a-zA-Z]/).reject{|e| e == "I"}
s.scan(/[a-zA-Z]/).reject{|e| e == "I" || e.empty?}
s.split(/[^a-z^A-Z]/).reject{|e| e == "I"}
```

## match a string against a regexp

```ruby
"fox@berkeley.EDU" =~ /(.*)@(.*)\.edu$/i
/(.*)@(.*)\.edu$/i =~ "fox@berkeley.EDU"
```



If no match, value is false

If match, value is non-false, and `$1`...`$n` capture parenthesized groups
```ruby
$1 == 'fox'
$2 == 'berkeley'
```



`/(.*)$/i` or

`%r{(.*)$}i`or

`Regexp.new('(.*)$', Regexp::IGNORECASE)`



=~ true if patterns match

!~ false if patterns match



# Regular Expressions

1. Most of Ruby’s built-in types will be familiar to all programmers. A majority of languages have strings, integers, ﬂoats, arrays, and so on. However, **regular expression** support is typically built into only scripting languages, such as Ruby, Perl, and awk.

   This is a shame: regular expressions, although cryptic, are a powerful tool for working with text. And having them built in, rather than tacked on through a library interface, makes a big difference.

2. A regular expression is simply a way of specifying a pattern of characters to be matched in a string. In Ruby, you typically create a regular expression by writing a pattern between **slash characters (/pattern/)**. And, Ruby being Ruby, regular expressions are objects and can be manipulated as such.

3. `/Perl|Python/` or `/P(erl|ython)/`
   The forward slashes delimit the pattern, which consists of the two things we’re matching, separated by a pipe character (|). This pipe character means “either the thing on the right or the thing on the left,” in this case either Perl or Python. You can use parentheses within patterns, just as you can in arithmetic expressions, so you could also have written this pattern as

4. `/ab+c/` matches a string containing an a followed by one or more b’s, followed by a c.

5. Change the plus to an asterisk, and `/ab*c/` creates a regular expression that matches one a, zero or more b’s, and one c.

6. Some example
   ![3](ch3.1_ruby.assets/3.png)

   ![2](ch3.1_ruby.assets/2.png)

   

7. Use patern. The **match operator =~** can be used to match a string against a regular expression.

   If the pattern is found in the string, =~ returns its starting position, otherwise it returns nil. This means you can use regular expressions as the condition in if and while statements.

   ```ruby
   if line =~ /Perl|Python/
   	  puts "pattern found: #{line}"
   end
   ```

8. Replace the matched pattern

   ```ruby
   line.sub(/Perl/, 'Ruby') # replace first 'Perl' with 'Ruby'
   line.gsub(/Perl/, 'Ruby') # replace every 'Perl' with 'Ruby'
   ```



## Examples

You are given the following short list of movies exported from an Excel comma-separated values (CSV) file. Each entry is a single string that contains the movie name in double quotes, zero or more spaces, and the movie rating in double quotes. For example, here is a list with three entries:

```ruby
    movies = [%q{"Aladdin",   "G"},
              %q{"I, Robot", "PG-13"},
              %q{"Star Wars","PG"}]
```

Your job is to create a regular expression to help parse this list:

```ruby
movies.each do |movie|
    movie.match(regexp)
    title,rating = $1,$2
end
```

For first entry, title should be Aladdin, rating should be G, WITHOUT the double quotes.

You may assume movie titles and ratings never contain double-quote marks. Within a single entry, a variable number of spaces (including 0) may appear between the comma after the title and the opening quote of the rating.

Which of the following regular expressions will accomplish this? Check all that apply.

```ruby
regexp = /"([^"]+)",\s*"([^"]+)"/   # yes
regexp = /"(.*)",\s*"(.*)"/			# yes
regexp = /"(.*)", "(.*)"/
regexp = /(.*),\s*(.*)/
```

at least one character that is **not** a `"` surrounded by `"`



# Ruby is an object oriented language

1. In Ruby, you’d deﬁne a **class** to represent each of these entities. A class is a combination of state -- **instance variable** (for example, the name of the song) and **instance methods** that use that state (perhaps a method to play the song).

   Methods are invoked by sending a **message** to an object. The message contains the method’s name, along with any parameters the method may need. When an object receives a message, it looks into its own class for a corresponding method. If found, that method is executed.

2. Once you have these classes, you’ll typically want to create a number of **instances** of each.

   In Ruby, these objects are created by calling a **constructor**, a special method associated with a class. The standard constructor is called **new**.

   ```ruby
   song1 = Song.new("aaa")
   song2 = Song.new("bbb")
   ```

3. invoke a method

   ```ruby
   "asdf".length
   "Rick".index("c")
   -1924.abs
   ```

   ```java
   number = Math.abs(number) // Java code
   ```

# Some baisc Ruby

1. Addition of string

   ```ruby
   def say_goodnight(name)
     result =  "Good Night, " + name
     return result
   end
   
   puts say_goodnight("John-Boy")
   puts say_goodnight("Mary")
   ```

2. Using expression interpolation

   ```ruby
   def say_goodnight(name)
     result =  "Good Night, #{name.capitalize}"
     return result
   end
   puts say_goodnight("harry")
   ```

3. Difference between double quote and single quote

   ```ruby
   def say_goodnight(name)
     result =  'Good Night, #{name}'
     return result
   end
   puts say_goodnight("Harry")
   ```

4. As a shortcut, you don’t need to supply the braces when the expression is simply a global, instance, or class variable

   ```ruby
   $greeting = "hello" #global variable
   @name = "Prudence" #instance variable
   puts "#$greeting, #@name"
   ```

5. The value returned by a Ruby method is the value of the last expression evaluated, so we can get rid of the temporary variable and the return statement altogether.

   ```ruby
   # no return needed
   def say_goodnight(name)
     result =  "Good Night, #{name}"
   end
   puts say_goodnight("Eason")
   ```

6. Name convention in Ruby:
   The ﬁrst characters of a name indicate how the name is used.

   1. Local variables, method parameters, and method names should all start with a lowercase letter or with an underscore.
   2. Global variables are preﬁxed with a dollar sign ($), and instance variables begin with an “at” sign (@).
   3. Class variables start with two “at” signs (@@).
   4. Finally, class names, module names, and constants must start with an uppercase letter.

   By convention multiword instance variables are written with underscores between the words,

   Multiword class names are written in MixedCase (with each word capitalized).

   Method names may end with the characters ?, !, and =.
   ![1](ch3.1_ruby.assets/1.png)

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

3. %w in array

   ```ruby
   a = [ 'ant', 'bee', 'cat', 'dog', 'elk' ]
   puts a
   b = %w{ ant bee cat dog elk }
   puts b
   ```

   a and b are same array here

4. Hash

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



# Blocks and iterators

1. Code blocks: chunks of code you can associate with method invocations, almost as if they were parameters.

   We try to follow what is becoming a Ruby standard and use braces for single-line blocks and do/end for multiline blocks.

2. single line block

   ```ruby
   {puts "hello"} # a single line code block
   ```

3. multi line block

   ```ruby
   do
     puts "aaa"
     puts "bbb"
   end
   ```

4. yield

   ```ruby
   def call_block
     puts "Start"
     yield
     yield
     puts "End"
   end
   call_block {puts "in the block"}
   ```

   give us

   ```
   Start
   in the block
   in the block
   End
   ```

5. another example

   ```ruby
   animals = %w( ant bee cat dog elk)
   animals.each{|animals| puts animals}
   animals.each{|name| print name, " "}
   5.times {print "*"}
   3.upto(6) {|i| print i}
   ('a'..'e').each {|char| print char}
   ```

6. example

   ```ruby
   class Person
       def initialize( name )
            @name = name
       end
   
       def do_with_name
           yield( @name )
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
   ```

7. eg

   ```ruby
   days = ["monday", "tuesday", "wednesday", "thursday", "friday"]
   # select those which start with 't'
   days.select do |item|
     item.match /^t/
   end
   ```

# Reading and Writing

1. **puts** writes its arguments, adding a newline after each.

2. **print** also writes its arguments, but with no newline. Both can be used to write to any I/O object, but by default they write to standard output.

3. Another output method we use a lot is **printf**, which prints its arguments under the control of a format string

   ```ruby
   printf("Number: %5.2f,\nString: %s \n",1.23,"hello")
   ```

4. input

   ```ruby
   line = gets
   print line
   ```

