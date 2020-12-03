
require './Member.rb'

@email  = "test_1203_2@matcher.com"
m = Member.new(email: @email)


orders = [
      {
        price_ratio: 0.16,
        volume: 10,
      },
      {
        price_ratio: 0.15,
        volume: 8,
      },
      {
        price_ratio: 0.13,
        volume: 6,
      },
      {
        price_ratio: 0.12,
        volume: 4,
      },
      {
        price_ratio: 0.09,
        volume: 2.8,
      },
      {
        price_ratio: 0.08,
        volume: 2.2,
      },
      {
        price_ratio: 0.07,
        volume: 2.1,
      },
      {
        price_ratio: 0.06,
        volume: 2,
      },

      # 对冲机器人
      {
        price_ratio: 0.05,
        volume: 0.1,
      },
      # 下面开始是买单
      {
        price_ratio: -0.05,
        volume: 0.03
      },
      {
        price_ratio: -0.06,
        volume: 0.05
      },
      {
        price_ratio: -0.08,
        volume: 0.06
      },
      {
        price_ratio: -0.09,
        volume: 0.07
      },
      {
        price_ratio: -0.10,
        volume: 0.08,
      },
      {
        price_ratio: -0.12,
        volume: 0.12,
      },
      {
        price_ratio: -0.13,
        volume: 0.23,
      },
      {
        price_ratio: -0.14,
        volume: 0.34,
      },
      {
        price_ratio: -0.15,
        volume: 0.445,
      }
]

orders = [
      {
        price_ratio: -0.15,
        volume: 0.445,
      }
]

@count = 0
loop do
  p '开始挂单'
  orders.each do |order|
    price_ratio = order[:price_ratio].to_f
    volume = order[:volume].to_f
    volume = (volume + ( 1 + rand(90))).round(0)
    price = ((1 + price_ratio*0.1) * 10).round(2)
    # 开始挂单
    is_ask = true
    p "#{is_ask ? '卖单': '买单'} 价格 #{price} 数量 #{volume}"
    is_continue = m.create_order  is_ask,  volume, price
    @count += 1
    p @count
    if @count % 5 == 0
      m.rand_cancel_a_order
    end
    # 休市之后自动停止脚本
    break if is_continue == false
    sleep 0.5
  end
end



