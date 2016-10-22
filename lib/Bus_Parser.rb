require 'uri'

class Bus_Parser
    
    def getAddressBusNo(bus_no)
        
        array = bus_no.to_s.split('-')
        
        if array.size > 1
            url = "http://m.jeonjuits.go.kr/traffic/bus_location1.jsp?search_nm="+bus_no+"inp_brt_id_route="+array[0]+"&inp_brt_class_route="+array[1]
        else
            url = "http://m.jeonjuits.go.kr/traffic/bus_location1.jsp?search_nm="+bus_no+"&inp_brt_id_route="+array[0]
        end
       
       return url
    end
    
    def getAddressBusStop(stop_name)
        
        val = stop_name.encode('euc-kr')
        url = "http://m.jeonjuits.go.kr/traffic/bus_location2.jsp?search_nm="+val
        uri = URI(URI.encode(url))
   
        return uri.to_s
    end
    
    
end