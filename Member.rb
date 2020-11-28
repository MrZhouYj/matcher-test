require 'net/http'
require 'uri'
require 'json'

class Member
  def initialize options = {}
    email = options[:email]
    url = URI.parse("http://api.test-sctajik.top/mobile_api/v2/common/get_member_public_key?email=#{email}")
    response = Net::HTTP.get(url)
    json_body = JSON.parse(response)
    @public_key = json_body['public_key']
    @private_key = json_body['private_key']
  end
  def public_key
    @public_key
  end
  def private_key
    @private_key
  end
end

