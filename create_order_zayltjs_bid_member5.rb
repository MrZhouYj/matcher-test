require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "ceshi_matcher_5@qq.com"

m = Member.new(email: @email, market_id: 'zayltjs')

@count = 0
loop do
  is_continue = m.create_order  false,  (1+rand(1000)/100),  (2.9 + rand(100)/50.0/10.0).round(2)
   p @count
   break if is_continue == false
end
