# Module
A module is a collection of methods that aren't a class. 

- You can't instantiate（实例化） it.

- Some modules are namespaces, similar to Python:  `Math::sin(Math::PI / 2.0)`

Important use of modules: **mix its methods into a class** 

```ruby
class A
    include MyModule
end
```

`A.foo` will search A, then MyModule, then method_missing in A & MyModule, then A's super

`sort` method is actually defined in module **Enumerable**,
 which is mixed into Array by default

**Enumerable assumes target object responds to `each` method**

provides: 

`all?, any?, collect, find, include?, inject, map, partition, ....`

**Enumerable** also provides `sort`, which **requires elements of collection (things returned by each) to respond to <=>**



**Comparable** assumes that target object responds to <=>(other_thing) 

provides
`<, <=, >=, >, ==, between? `
for free

**Class of objects doesn’t matter: only methods to which they respond**

## Example
```
a = SavingsAccount.new(100)
b = SavingsAccount.new(50)
c = SavingsAccount.new(75)
```
What is result of `[a,b,c].sort`

Doesn’t work, but would work if we defined <=> on  SavingsAccount

```ruby
class Account
    include Comparable
    def <=>(other)
        self.balance <=> other.balance
    end
end
```