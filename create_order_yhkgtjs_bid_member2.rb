require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "test-20201129-2@test.com"

m = Member.new(email: @email)

@count = 0
loop do
   is_continue = m.create_order  false,  (1+rand(1000)/100),  (9 + rand(100)/50.0).round(4)
   p @count
   break if is_continue == false
end
