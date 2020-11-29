require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "new-matcher_yhkg_1@test.com"
m = Member.new(email: @email)

@count = 0
loop do
   is_continue = m.create_order  true,  (1+rand(1000)/100),  (9 + rand(100)/50.0).round(3)
   p @count
   break if is_continue == false
end









