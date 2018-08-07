require 'net/http'
require 'net/https'
require 'uri'

TARGET_URL = 'https://notify-api.line.me/api/notify'
TOKEN = # 토큰

header = {
  'Authorization': 'Bearer ' + TOKEN
}

uri = URI.parse(TARGET_URL)
https = Net::HTTP.new(uri.host,uri.port)
https.use_ssl = true
req = Net::HTTP::Post.new(uri.path, header)
req.set_form_data({'message' => '테스트입니다.'}, ';')
res = https.request(req)

puts "Response #{res.code} #{res.message}: #{res.body}"