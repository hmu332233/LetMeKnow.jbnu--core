require 'BusTracer'

module M_Bus
    
    def makeMessage_bus_location
        
        busTracer = BusTracer.new
        
        bus_location = busTracer.trace(0)
        
        past_stop_name = busTracer.getNameData(0, bus_location[:past_stop])
        current_stop = busTracer.getNameData(0, bus_location[:current_stop])
        next_stop = busTracer.getNameData(0, bus_location[:next_stop])
        
        return "#{past_stop_name}\n#{current_stop}\n#{next_stop}"
    end
    
    def makeMessage_bus_time
        return '버스시간'
    end
end