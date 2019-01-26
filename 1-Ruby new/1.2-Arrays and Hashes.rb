a = [1,'cat',3.14] #array
puts a[0]
a[2] = nil
puts a

# %w
a = [ 'ant', 'bee', 'cat', 'dog', 'elk' ]
puts a
b = %w{ ant bee cat dog elk }
puts b

# hash
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
