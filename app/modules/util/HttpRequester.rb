require 'util/TimeHelper'

class HttpRequester
  def self.requestNokogiriHtml(url)
    uri = URI(URI.encode(url))  
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
    doc = Nokogiri::HTML(res.body)
    return doc    
  end
end