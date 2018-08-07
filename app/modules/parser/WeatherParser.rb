require 'Weather'

class WeatherParser
    
    
     def requestHTML
        uri = URI(URI.encode("http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=4511358000"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::XML(res.body)
    
        return doc
    end
    
    def requestXML_week
        uri = URI(URI.encode("http://www.weather.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=146"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::XML(res.body)

        return doc
    end
    
    def getWeekDayWeather
        doc = requestXML_week
    
        days = doc.xpath("//tmEf")
        tmx = doc.xpath("//tmx")
        tmn = doc.xpath("//tmn")
        wfKors = doc.xpath("//wf")
        
        weathers = []
        
        for i in 0..12
            weather = Weather.new("",days[i].inner_text.to_s,"",tmx[i].inner_text.to_s,tmn[i].inner_text.to_s,wfKors[i+1].inner_text.to_s,"")
            weathers << weather
        end
        
        return weathers
    end
    
    
    def getTodayWeather
        
        doc = requestHTML
        
        # doc.xpath("//data").each do |data|
            
        #     data.xpath("hour")[0]
        #     data.xpath("day")[0]
        #     data.xpath("temp")[0]
            
        # end
        
        hours = doc.xpath("//hour")
        
        days = doc.xpath("//day")
        
        temps = doc.xpath("//temp")
        
        tmx = doc.xpath("//tmx")
        
        tmn = doc.xpath("//tmn")
        
        wfKors = doc.xpath("//wfKor")
        
        pops = doc.xpath("//pop")
        
        weathers = []
        
        for i in 0..hours.length-1
            weather = Weather.new(hours[i].inner_text.to_s,days[i].inner_text.to_s,temps[i].inner_text.to_s,tmx[i].inner_text.to_s,tmn[i].inner_text.to_s,wfKors[i].inner_text.to_s,pops[i].inner_text.to_s)
            weathers << weather
        end
        
        return weathers
        
    end
    
end