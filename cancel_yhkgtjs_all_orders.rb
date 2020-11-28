require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "ceshi_matcher_3@qq.com"

m = Member.new(email: @email, market_id: 'yhkgtjs')
m.cancel_all_orders

@email  = "ceshi_matcher_4@qq.com"
m = Member.new(email: @email, market_id: 'yhkgtjs')
m.cancel_all_orders

@email  = "ceshi_matcher_5@qq.com"
m = Member.new(email: @email, market_id: 'zayltjs')
m.cancel_all_orders

@email  = "ceshi_matcher_6@qq.com"
m = Member.new(email: @email, market_id: 'zayltjs')
m.cancel_all_orders
