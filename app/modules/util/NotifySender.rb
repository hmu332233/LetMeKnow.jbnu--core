require 'net/http'
require 'uri'

class NotifySender
  def send(message)
    @@TARGET_URL = 'https://notify-api.line.me/api/notify'
    @@TOKEN = ENV['notify_token']

    header = {
      'Authorization': 'Bearer ' + @@TOKEN
    }

    uri = URI.parse(@@TARGET_URL)
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, header)
    req.set_form_data({'message' => message}, ';')
    res = https.request(req)
  end
end



