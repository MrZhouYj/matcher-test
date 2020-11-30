require './Member.rb'

@email  = "test_1130_2@test.com"

m = Member.new(email: @email, market_id: 'yhkgtjs')
m.cancel_all_orders


