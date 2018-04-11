#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
 
#require map
[1, 2, 3, 4, 5].each do |i|
    puts i ** 2
end


if /(Ruby)/i =~ "ruby" then
     p $1
end

/(.)(\d\d)+(.)/ =~ "123456"
p $1
p $2
p $3

/C./ =~ "ABCDEF"
p $` #=> "AB"
p $& #=> "CD"
p $' #=> "EF"

time1 = Time.new
 
puts "当前时间 : " + time1.inspect
 
# Time.now 功能相同
time2 = Time.now
puts "当前时间 : " + time2.inspect

# 指定范围
digits = 0..9

puts digits.include?(5)
ret = digits.min
puts "最小值为 #{ret}"
 
ret = digits.max
puts "最大值为 #{ret}"
 
ret = digits.reject {|i| i < 5 }
puts "不符合条件的有 #{ret}"
 
digits.each do |digit|
   puts "在循环中 #{digit}"
end


 
score = 70
 
result = case score
when 0..40
    "糟糕的分数"
when 41..60
    "快要及格"
when 61..70
    "及格分数"
when 71..100
       "良好分数"
else
    "错误的分数"
end
 
puts result


if ((1..10) === 5)
  puts "5 在 (1..10)"
end
 
if (('a'..'j') === 'c')
  puts "c 在 ('a'..'j')"
end
 
if (('a'..'j') === 'z')
  puts "z 在 ('a'..'j')"
end



a = [1,2,3,4,5]
b = a.collect{|x| 10*x}
#b = a.each do |x|  10*x end
puts b


hello1 = Proc.new do |name|
    puts "Hello, #{name}."
end

=begin 
hello2 = proc do |name|
    puts "Hello, #{name}."
end
=end

hello1.call("World") #=> Hello, World.
#hello2.call("Ruby") #=> Hello, Ruby.



double1 = Proc.new do |*args|
    args.map{|i| i * 2 } # 所有元素乘两倍
end

p double1.call(1, 2, 3) #=> [2, 3, 4]
p double1[2, 3, 4] #=> [4, 6, 8]


prc1 = Proc.new do |a, b, c|
    p [a, b, c]
end
prc1.call(1, 2) #=> [1, 2, nil]

prc2 = lambda do |a, b, c|
    p [a, b, c]
end
prc2.call(1, 2) #=> 错误（ArgumentError）


def power_of(n)
    lambda do |x|
        return x ** n
    end
end
cube = power_of(3)
p cube.call(5) #=> 125


def power_of(n)
    Proc.new do |x|
        return x ** n
    end
end
cube = power_of(3)
p cube
p cube.call(5) #=> 错误（LocalJumpError）


square = ->(n){ return n ** 2}
p square[5] #=> 25


def total2(from, to, &block)
    result = 0 # 合计值
    from.upto(to) do |num| # 处理从 from 到 to 的值
        if block # 如果有块的话
            result += # 累加经过块处理的值
            block.call(num)
        else # 如果没有块的话
            result += num # 直接累加
        end
    end
    return result # 返回方法的结果
end
p total2(1, 10) # 从 1 到 10 的和 => 55
p total2(1, 10){|num| num ** 2 } # 从 1 到 10 的 2 次冥的和 => 385


def myloop
    while true
        yield # 执行块
    end
end

num = 1 # 初始化num
myloop do
    puts "num is #{num}" # 输出num
    break if num > 100 # num 超过100 后跳出循环
    num *= 2 # num 乘2
end

n = total(1, 10) do |num|
    if num == 5
        break
    end
    num
end
p n #=> ??



p "abcasdfa \n afds".gsub(/$/, "!") #=> "abc\n!"
p "abc\n".gsub(/$/, "!") #=> "abc!\n!"