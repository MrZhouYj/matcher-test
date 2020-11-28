require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "ceshi_matcher_1@qq.com"

m = Member.new(email: @email)
m.cancel_all_orders

@email  = "ceshi_matcher_2@qq.com"
m = Member.new(email: @email)
m.cancel_all_orders
