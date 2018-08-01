require 'net/http'
require 'nokogiri'

class Parser
    
    def parse
        uri = URI(URI.encode("http://www.chonbuk.ac.kr/pj/pjDept.php?movePage=1&pageKey=63&TP=001&pid=336"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)

        table = doc.css(".table01//tbody//tr")
        
        
        table.each do |t|
            
            name = t.css("th")[0]
            office = t.css("td")[0]
            tel = t.css("td")[1]
            
            st = "Major.new(\""
            en = "\")"
            
            m = name.inner_text.squish.strip + "/" + office.inner_text.squish.strip + "/" + tel.inner_text.squish.strip.split("Fax")[0]+"/"+"Fax"+tel.inner_text.squish.strip.split("Fax")[1]
            
            print st + m + en + ",\n"

        end
    end   
end

Parser.new.parse