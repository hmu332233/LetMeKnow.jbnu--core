require 'BusTracer'

module M_Bus
    
    def makeMessage_bus_location
        
        busTracer = BusTracer.new
        
       return busTracer.trace()
        
        # return '버스위치'
    end
    
    def makeMessage_bus_time
        return '버스시간'
    end
end