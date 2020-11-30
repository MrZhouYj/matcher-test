require 'uri'
require 'net/http'
require 'digest'
require 'json'


class Member

  def initialize options = {}
    email = options[:email]
    @market_id = options[:market_id] || 'yhkgtjs'
    p email

    url = URI.parse("http://api.test-sctajik.top/mobile_api/v2/common/get_member_public_key?email=#{email}")
    response = Net::HTTP.get(url)
    p response
    json_body = JSON.parse(response)
    p json_body
    @public_key = json_body['public_key']
    @private_key = json_body['private_key']
  end

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
      price: price.round(2),
      public_key: @public_key,
      volume: volume
    }

    sleep 0.1
    url = URI.parse("http://new-matcher.test-sctajik.top/#{@market_id}/create_limit_order")
    params = params.merge({signature: get_signature(params)})
    p params
    response = Net::HTTP.post_form(url, params)
    if response.code == "200"
      resp = JSON(response.body)
      p resp
      if resp["message"] == '休市'
        return false
      else
        return true
      end
    end
    false
  end

  def cancel_all_orders
    params = {
      lang: "zh",
      market_id: @market_id,
      nonce: Time.now.to_i,
      public_key: @public_key,
    }

    url = URI.parse("http://new-matcher.test-sctajik.top/yhkgtjs/cancel_all_orders")
    params = params.merge({signature: get_signature(params)})
    response = Net::HTTP.post_form(url, params)
    if response.code == "200"
      resp = JSON(response.body)
      p resp
    end
  end
end

