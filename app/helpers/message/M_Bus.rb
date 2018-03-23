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
        
        if bus_location.nil?
            return "     운행 종료\n\n"
        end
        
        past_stop_name = busTracer.getNameData(bus_no, bus_location[:past_stop])
        current_stop = busTracer.getNameData(bus_no, bus_location[:current_stop])
        next_stop = busTracer.getNameData(bus_no, bus_location[:next_stop])

        course_name_list = busTracer.getNameData(bus_no)
        course_time_list = busTracer.getCourseTimeData(bus_no, bus_location[:course_index])
 
        text = ""
        
        course_name_list.each_with_index do |name, i|
            if i == bus_location[:current_stop]
                text += "◎  #{name}\n▼  #{course_time_list[i]}\n▼\n"
            elsif i == bus_location[:next_stop]
                text += "○  #{name}\n      #{course_time_list[i]}\n\n"
            else
                text += "     #{name}\n     #{course_time_list[i]}\n\n"
            end
        end
        
        return "#{text}"
    end
    
    def makeMessage_bus_time
        return "◆제 1노선[순환노선]◆

생활관(대동관) 
10:30  11:00  11:30
13:00  13:30  14:00

2학생회관 측면 
10:33  11:03  11:33
13:03  13:33  14:03

진수당 건너편 
10:35  11:05  11:35
13:05  13:35  14:05

생활대 입구 
10:37  11:07  11:37
13:07  13:37  14:07

상대 2호관 측면 
10:39  11:09  11:39
13:09  13:39  14:09

학습도서관 전면 
10:41  11:11  11:41
13:11  13:41  14:11

농생대본관 전면 
10:43  11:13  11:43
13:13  13:43  14:13

예체능관 측면 
10:45  11:15  11:45
13:15  13:45  14:15

생활관(대동관) 
10:50  11:20  11:50
13:20  13:50  14:20


◆제 2노선[왕복노선]◆

생활관(대동관) 
10:30  11:00  11:30
13:00  13:30  14:00

2학생회관 측면 
10:33  11:03  11:33
13:03  13:33  14:03

대학본부 측면 
10:35  11:05  11:35
13:05  13:35  14:05

정보전산원 후면(1) 
10:37  11:07  11:37
13:07  13:37  14:07

치의학전문대학입구(1)
10:39  11:09  11:39
13:09  13:39  14:09

의대 학생회관 
10:41  11:11  11:41
13:11  13:41  14:11

정보전산원 후면(2) 
10:45  11:15  11:45
13:15  13:45  14:15

진수당 입구 
10:53  11:23  11:53
13:23  13:53  14:23

예체능관 측면 
10:55  11:25  11:50
13:25  13:55  14:25

생활관[대동관] 
11:00  11:30  12:00
13:30  14:00  14:30"
    end
end