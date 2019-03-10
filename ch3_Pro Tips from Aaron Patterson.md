# Ruby Pro Tips from Rails Core Committer Aaron Patterson
### Where is that method?
Q: This code is calling a method, but I don't know where the method is defined. How can I find it?

A: Use the `method` method. The `method` method will return a method object and let you call source_location to find the method location. For example:

p object.method(:unknown_method).source_location

If object has the instance method unknown_method, this code will print the location of that method.

### Who is calling me?
Q: I'm inside a method, but I don't know who called this method. How can I find out?

A: Use the caller method. The caller method will give you the current stack trace, so you can do p caller and see who is calling you. Alternatively, just raise an exception, and you'll see the backtrace.

### What is my class?
Q: I'm editing a method, but I'm not sure what class it's defined on. How can I find out?

A: Use the class method. For example:

def foo
  p self.class
end
This will print out the class of self which is your current instance.

### What is my superclass?
Q: I am editing a method that calls super, like this:
```ruby
def foo
  # ...
  super
  # ...
end
```
I want to know where the superclass method is defined. How do I find it?

A: You can use the superclass method on the class to get the superclass. For example:
```ruby
def foo
  # ...
  p self.class.superclass.instance_method(:foo).source_location
  super
  # ...
end
```
One caveat is that the method may not be defined on your superclass, but somewhere further up the inheritance chain. You can find that by using ancestors. For example:
```ruby
def foo
  # ...
  self.class.ancestors.each do |klass|
    next unless klass.method_defined?(:foo)
    p klass.instance_method(:foo).source_location
  end
  super
  # ...
end
```
I need a debugger!
I personally don't use a debugger, but I've heard the debugger gem is good.