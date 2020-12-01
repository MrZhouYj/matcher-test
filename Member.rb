require 'uri'
require 'net/http'
require 'digest'
require 'json'


class Member

  def initialize options = {}
    email = options[:email]
    @market_id = options[:market_id] || 'yhkgtjs'
    @orders = []

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

    p '创建订单'
    params = {
      is_ask: is_ask,
      lang: "zh",
      market_id: @market_id,
      nonce: Time.now.to_i,
      price: price.round(2),
      public_key: @public_key,
      volume: volume
    }

    url = URI.parse("http://new-matcher.test-sctajik.top/#{@market_id}/create_limit_order")
    params = params.merge({signature: get_signature(params)})
    p params
    response = Net::HTTP.post_form(url, params)
    p response
    if response.code == "200"
      resp = JSON(response.body)
      p resp
      if resp["message"] == '休市'
        return false
      else
        @orders << resp["order_id"]
        return true
      end
    end
    false
  end

  def rand_cancel_a_order
      cancel_a_order @orders.last
  end

  def cancel_a_order id

    p '取消订单'
    params = {
      id: id,
      lang: "zh",
      nonce: Time.now.to_i,
      public_key: @public_key,
    }
    p params

    url = URI.parse("http://new-matcher.test-sctajik.top/#{@market_id}/cancel_order")
    params = params.merge({signature: get_signature(params)})
    response = Net::HTTP.post_form(url, params)
    p response
    if response.code == "200"
      resp = JSON(response.body)
      p resp
    end
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
    p response
    if response.code == "200"
      resp = JSON(response.body)
      p resp
    end
  end
end

