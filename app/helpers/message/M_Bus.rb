require 'BusTracer'

module M_Bus
    
    def makeMessage_bus_location
        
         now = TimeHelper.new.now
        
        text = "#{now}\n\n"
        text += "◆제 1노선 [순환노선]◆\n\n"
        text += makeMessage_bus_location_with_index(0)
        text += "\n"
        text += "◆제 2노선 [왕복노선]◆\n\n"
        text += makeMessage_bus_location_with_index(1)
        text += "◎: 예상위치 ○: 오차범위"
        
        return "#{text}"
    end
    
    def makeMessage_bus_location_with_index(bus_no)
        busTracer = BusTracer.new
        bus_location = busTracer.trace(bus_no)
        
        past_stop_name = busTracer.getNameData(bus_no, bus_location[:past_stop])
        current_stop = busTracer.getNameData(bus_no, bus_location[:current_stop])
        next_stop = busTracer.getNameData(bus_no, bus_location[:next_stop])

        course_name_list = busTracer.getNameData(bus_no)
        course_time_list = busTracer.getCourseTimeData(bus_no, bus_location[:course_index])
 
        text = ""
        
        course_name_list.each_with_index do |name, i|
            if i == bus_location[:current_stop]
                text += "◎ #{name}\n    #{course_time_list[i]}\n\n"
            elsif i == bus_location[:past_stop] || i == bus_location[:next_stop]
                text += "○ #{name}\n    #{course_time_list[i]}\n\n"
            else
                text += "    #{name}\n    #{course_time_list[i]}\n\n"
            end
        end
        
        return "#{text}"
    end
    
    def makeMessage_bus_time
        return '버스시간'
    end
end