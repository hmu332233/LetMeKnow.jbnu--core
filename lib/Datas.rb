class Datas
    
    def getChick
        
        uri = URI(URI.encode("https://openapi.naver.com/v1/search/local.xml?display=30&start=1&query=치킨 전북대"))

        req = Net::HTTP::Get.new(uri)
        
        req['X-Naver-Client-Id'] = ENV["naver_id"]
        req['X-Naver-Client-Secret'] = ENV["naver_sc"]
        
        
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }

        
        xml_doc = Nokogiri::XML(res.body)
        
        chik_array = []
        
        xml_doc.xpath("//item").each do |item|
            title = item.xpath("title")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            tele = item.xpath("telephone")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            
            chik_array << [title,tele]
        end

        return chik_array
    end
    
    def getChina
        
        uri = URI(URI.encode("https://apis.daum.net/local/v1/search/keyword.xml?apikey=#{ENV["daum_id"]}&location=35.84674878005919,127.12942528419897&radius=5000&query=+"+"중국집"+"+&page=1&sort=0"))

        req = Net::HTTP::Get.new(uri)
 
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }

        xml_doc = Nokogiri::XML(res.body)
        
        print xml_doc
        
        chik_array = []
        
        xml_doc.xpath("//item").each do |item|
            title = item.xpath("title")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            tele = item.xpath("phone")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            
            chik_array << [title,tele]
        end

        return chik_array
        
    end
    
end