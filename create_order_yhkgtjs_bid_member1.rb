require './Member.rb'

@email  = "@test_1130_1@test.com"

m = Member.new(email: @email)

@count = 0
loop do
   is_continue = m.create_order  false,  (1+rand(1000)/100),  (9 + rand(100)/50.0).round(3)
   p @count
   break if is_continue == false
end
