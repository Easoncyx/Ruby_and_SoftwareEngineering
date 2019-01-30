# a = [1,3,5,7,9]
# a[2,1] = ['a','b']
# puts a

arr = [1,3,5,7,9]
n = 8
dic = {}

0.upto(arr.length - 1) do |i|
  if dic.key?(arr[i])
    puts "true"
  else
    puts "i = " + i.to_s
    puts "n-arr[i] = " + (n-arr[i]).to_s
    dic[n-arr[i]] = i
  end
end
puts dic
puts arr.length
