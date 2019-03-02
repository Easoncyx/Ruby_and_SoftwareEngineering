# defined? variable 如果 variable 已经初始化，则为 True
foo = 42
puts defined? foo    # => "local-variable"
puts defined? $_     # => "global-variable"
puts defined? bar    # => nil（未定义）

# defined? method_call 如果方法已经定义，则为 True
puts defined? puts        # => "method"
puts defined? puts(bar)   # => nil（在这里 bar 未定义）
puts defined? unpack      # => nil（在这里未定义）

# 如果存在可被 super 用户调用的方法，则为 True
puts defined? super

# 如果已传递代码块，则为 True
puts defined? yield

a,b=10,20
puts a <=> b

a,b = b,a
puts a, b

(1..3).each do |i|
  puts i
end
(1...3).each do |i|
  puts i
end


MR_COUNT = 0        # 定义在主 Object 类上的常量
module Foo
  MR_COUNT = 0
  ::MR_COUNT = 1    # 设置全局计数为 1
  MR_COUNT = 2      # 设置局部计数为 2
end
puts MR_COUNT       # 这是全局常量
puts Foo::MR_COUNT  # 这是 "Foo" 的局部常量


CONST = ' out there'
class Inside_one
   CONST = proc {' in there'}
   def where_is_my_CONST
      ::CONST + ' inside one'
   end
end
class Inside_two
   CONST = ' inside two'
   def where_is_my_CONST
      CONST
   end
end
puts Inside_one.new.where_is_my_CONST
puts Inside_two.new.where_is_my_CONST
puts Object::CONST + Inside_two::CONST
puts Inside_two::CONST + CONST
puts Inside_one::CONST
puts Inside_one::CONST.call + Inside_two::CONST
