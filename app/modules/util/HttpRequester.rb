class HttpRequester
  def self.requestNokogiriHtml(url)
    uri = URI(URI.encode(url))  
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
    doc = Nokogiri::HTML(res.body)
    return doc
  end
  
  def self.requestPostWithJson(url, json)
    uri = URI(url)
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    req.body = json
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end
  
  def self.requestGetReturnJson(url)
    uri = URI(URI.encode(url))  
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
    return JSON.parse(res.body)
  end
end