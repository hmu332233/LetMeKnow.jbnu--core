require 'uri'
require 'Bus'

class Bus_Parser
    
    def getAddressBusNo(bus_no)
        
        array = bus_no.to_s.split('-')
        
        if array.size > 1
            url = "http://m.jeonjuits.go.kr/traffic/bus_location1.jsp?search_nm="+bus_no+"&inp_brt_id_route="+array[0]+"&inp_brt_class_route="+array[1]
        else
            url = "http://m.jeonjuits.go.kr/traffic/bus_location1.jsp?search_nm="+bus_no+"&inp_brt_id_route="+array[0]
        end
        
        puts url
       
       return url
    end
    
    def getAddressBusStop(stop_name)
        
        val = stop_name.encode('euc-kr')
        url = "http://m.jeonjuits.go.kr/traffic/bus_location2.jsp?search_nm="+val
        uri = URI(URI.encode(url))
        
        puts uri
   
        return uri.to_s
    end
    
    
    def getSelectedBusStop(id)
        
        # 전북대학교(한나여성병원)
        hanna_url = "http://m.jeonjuits.go.kr/traffic/bus_location_busstop_infomation.jsp?stop_stdid=306101049&stop_nm=%C0%FC%BA%CF%B4%EB%C7%D0%B1%B3(%C7%D1%B3%AA%BF%A9%BC%BA%BA%B4%BF%F8%BE%D5)&stdno="
        # 전북대학교(일양병원앞)
        il_url = "http://m.jeonjuits.go.kr/traffic/bus_location_busstop_infomation.jsp?stop_stdid=306101035&stop_nm=%C0%FC%BA%CF%B4%EB%C7%D0%B1%B3(%C0%CF%BE%E7%BA%B4%BF%F8%BE%D5)&stdno="
        # 전북대학교(덕진성당앞)
        sung_url = "http://m.jeonjuits.go.kr/traffic/bus_location_busstop_infomation.jsp?stop_stdid=306101051&stop_nm=%C0%FC%BA%CF%B4%EB%C7%D0%B1%B3(%B4%F6%C1%F8%BC%BA%B4%E7%BE%D5)&stdno="
        # 소방서(시청방향)
        fire_url = "http://m.jeonjuits.go.kr/traffic/bus_location_busstop_infomation.jsp?stop_stdid=306101027&stop_nm=%C0%FC%C1%D6%BC%D2%B9%E6%BC%AD&stdno="
        # 전북은행본점
        jb_bank_url = "http://m.jeonjuits.go.kr/traffic/bus_location_busstop_infomation.jsp?stop_stdid=306101017&stop_nm=%C0%FC%BA%CF%C0%BA%C7%E0%BA%BB%C1%A1&stdno="
        # 전북대학교(농협앞)
        nong_url = "http://m.jeonjuits.go.kr/traffic/bus_location_busstop_infomation.jsp?stop_stdid=306101044&stop_nm=%C0%FC%BA%CF%B4%EB%C7%D0%B1%B3(%B3%F3%C7%F9%BE%D5)&stdno="
        
        target_url = [nong_url,jb_bank_url,fire_url,sung_url,il_url,hanna_url]
        
        
        uri = URI(URI.encode(target_url[id]))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
        
        bus_datas = doc.css("#bus_result_warp")
        
        buses = []
        
        i = 0
        while(i < bus_datas.length)
        
            number = bus_datas[i].inner_text.strip.squish.split(" : ")[1]
            arrive_time = bus_datas[i+2].inner_text.strip.squish.split(" : ")[1].split("분")[0].to_i
            remain_busstop_num = bus_datas[i+3].inner_text.strip.squish.split(" : ")[1]
            lately_busstop = bus_datas[i+4].inner_text.strip.squish.split(" : ")[1]
        
            # puts bus_datas[i].inner_text.strip.squish
            buses << Bus.new(number,arrive_time,remain_busstop_num,lately_busstop)
            i += 6
        
        end
      
        return buses.sort_by! &:arrive_time
        # return buses
        
    end
    
    
end

# 전북은행 앞
# 신정문 앞

# 농협 앞
# 성당앞
# 맥날 옆

# LGU+ 앞