require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = "test-20201129-1@test.com"

m = Member.new(email: @email, market_id: 'yhkgtjs')
m.cancel_all_orders

#@email  = "matcher_yhkg_2@test.com"
#m = Member.new(email: @email, market_id: 'yhkgtjs')
#m.cancel_all_orders

