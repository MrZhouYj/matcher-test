require 'uri'
require 'net/http'
require 'digest'
require 'json'
require './Member.rb'

@email  = ""
@market_id = "yhkgtjs"

m = Member.new(email: @email)

@public_key = m.public_key
@private_key = m.private_key

@market_id = "yhkgtjs"

@reference_price = 10

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


params = {
  lang: "zh",
  market_id: @market_id,
  nonce: Time.now.to_i,
  public_key: @public_key,
}

url = URI.parse("http://new-matcher.test-sctajik.top/yhkgtjs/cancel_all_orders")
params = params.merge({signature: get_signature(params)})
p params
response = Net::HTTP.post_form(url, params)
p response
if response.code == "200"
  resp = JSON(response.body)
  p resp
end


