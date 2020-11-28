require 'uri'
require 'net/http'
require 'digest'
require 'json'

@public_key = "4f4de1ab-4553-46bf-8c8e-c5fee2b53876"
@private_key = "5bdbb75d-4448-418f-9963-dc01a4376808"

@market_id = "yhkgtjs"

@reference_price = 10
@success_count = 0 #挂单成功次数

# 下单接口

def get_signature(hash)
  parameter_string_before_md5 = hash
    .select{ |key, value| value != nil } # 去掉 空值参数
    .sort_by{|key, value| key}  # 按照字母顺序排序
    .map{ |e| "#{e.first}=#{e.last}" }  # 把得到的内容整理成字符串
    .join("&")
  total_string_before_md5 = parameter_string_before_md5 + "&private_key=#{@private_key}"
  signature = Digest::MD5.hexdigest(total_string_before_md5)
  return signature
end

def create_order is_ask, volume, price

  params = {
    is_ask: is_ask,
    lang: "zh",
    market_id: @market_id,
    nonce: Time.now.to_i,
    price: price,
    public_key: @public_key,
    volume: volume
  }

  url = URI.parse("http://new-matcher.test-sctajik.top/yhkgtjs/create_limit_order")
  params = params.merge({signature: get_signature(params)})
  p params
  response = Net::HTTP.post_form(url, params)
  p response
  if response.code == "200"
    resp = JSON(response.body)
    @success_count += 1
    p "成功挂单 #{@success_count} 次"
    p resp
  end
end


loop do
    p '开始挂卖单'
    create_order  true,  (1+rand(1000)/100),  9 + rand(100)/50.0.round(2)
end









