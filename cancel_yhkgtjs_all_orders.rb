require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "matcher_yhkg_1@test.com"

m = Member.new(email: @email, market_id: 'yhkgtjs')
m.cancel_all_orders

@email  = "matcher_yhkg_2@test.com"
m = Member.new(email: @email, market_id: 'yhkgtjs')
m.cancel_all_orders

