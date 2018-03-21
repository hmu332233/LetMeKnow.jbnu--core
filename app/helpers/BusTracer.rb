require 'util/TimeHelper'

class BusTracer
  
  def getNameData(bus_no, index) 
    no1 = [
      '생활관(대동관)',
      '2학생회관 측면',
      '진수당 건너편',
      '생활대 입구',
      '상대 2호관 측면',
      '학습도서관 전면',
      '농생대본관 전면',
      '예체능관 측면',
      '생활관(대동관)'
    ]
    
    no2 = [
      '생활관(대동관)',
      '2학생회관 측면',
      '대학본부 측면',
      '정보전산원 후면(1)',
      '치의학전문대학입구(1)',
      '의대 학생회관',
      '정보전산원 후면(2)',
      '진수당 입구',
      '예체능관 측면',
      '생활관[대동관]'
    ]
    
    
    
    if bus_no == 0
      
      if index > no1.size - 1
        index = 0
      elsif index < 0
        index = no1.size - 1
      end
      
      return no1[index]
    else
      
      if index > no2.size - 1
        index = 0
      elsif index < 0
        index = no2.size - 1
      end
      
      return no2[index]
    end
  end
   
  def getTimeData(type, index)
     
    no1 = [
      ["10:30", "11:00", "11:30", "13:00", "13:30", "14:00"],
      ["10:33", "11:03", "11:33", "13:03", "13:33", "14:03"],
      ["10:35", "11:05", "11:35", "13:05", "13:35", "14:05"],
      ["10:37", "11:07", "11:37", "13:07", "13:37", "14:07"],
      ["10:39", "11:09", "11:39", "13:09", "13:39", "14:09"],
      ["10:41", "11:11", "11:41", "13:11", "13:41", "14:11"],
      ["10:43", "11:13", "11:43", "13:13", "13:43", "14:13"],
      ["10:45", "11:15", "11:45", "13:15", "13:45", "14:15"],
      ["10:50", "11:20", "11:50", "13:20", "13:50", "14:20"]
    ]
    
    no1_reverse = [
      ["10:30", "10:33", "10:35", "10:37", "10:39", "10:41", "10:43", "10:45", "10:50"],
      ["11:00", "11:03", "11:05", "11:07", "11:09", "11:11", "11:13", "11:15", "11:20"],
      ["11:30", "11:33", "11:35", "11:37", "11:39", "11:41", "11:43", "11:45", "11:50"],
      ["13:00", "13:03", "13:05", "13:07", "13:09", "13:11", "13:13", "13:15", "13:20"],
      ["13:30", "13:33", "13:35", "13:37", "13:39", "13:41", "13:43", "13:45", "13:50"],
      ["14:00", "14:03", "14:05", "14:07", "14:09", "14:11", "14:13", "14:15", "14:20"] 
    ]
    
    no2 = [
      ["10:30", "11:00", "11:30", "13:00", "13:30", "14:00"],
      ["10:33", "11:03", "11:33", "13:03", "13:33", "14:03"],
      ["10:35", "11:05", "11:35", "13:05", "13:35", "14:05"],
      ["10:37", "11:07", "11:37", "13:07", "13:37", "14:07"],
      ["10:39", "11:09", "11:39", "13:09", "13:39", "14:09"],
      ["10:41", "11:11", "11:41", "13:11", "13:41", "14:11"],
      ["10:45", "11:15", "11:45", "13:15", "13:45", "14:15"],
      ["10:53", "11:23", "11:53", "13:23", "13:53", "14:23"],
      ["10:55", "11:25", "11:55", "13:25", "13:55", "14:25"],
      ["11:00", "11:30", "12:00", "13:30", "14:00", "14:30"]
    ]
    
    no2_reverse = [
      ["10:30", "10:33", "10:35", "10:37", "10:39", "10:41", "10:45", "10:53", "10:55", "11:00" ],
      ["11:00", "11:03", "11:05", "11:07", "11:09", "11:11", "11:15", "11:23", "11:25", "11:30" ],
      ["11:30", "11:33", "11:35", "11:37", "11:39", "11:41", "11:45", "11:53", "11:55", "12:00" ],
      ["13:00", "13:03", "13:05", "13:07", "13:09", "13:11", "13:15", "13:23", "13:25", "13:30" ],
      ["13:30", "13:33", "13:35", "13:37", "13:39", "13:41", "13:45", "13:53", "13:55", "14:00" ],
      ["14:00", "14:03", "14:05", "14:07", "14:09", "14:11", "14:15", "14:23", "14:25", "14:30" ]
    ]
    
    if type == 'reverse'
      return [no1_reverse, no2_reverse][index]
    else
      return [no1, no2][index]
    end
  end
  
  def trace(no)
    now = TimeHelper.new.now
    puts now
    nearestTimeData = getNearestTime(no)
    puts nearestTimeData[:time]
    
    course_index = nearestTimeData[:index][0]
    arriving_index = nearestTimeData[:index][1]
    puts '오차범위: ' + getNameData(no, arriving_index-2)
    puts '현재위치: ' + getNameData(no, arriving_index-1)
    puts '오차범위: ' + getNameData(no, arriving_index)
     
    return {
      course_index: course_index,
      past_stop: arriving_index-2,
      current_stop: arriving_index-1,
      next_stop: arriving_index
    }
  end
  
  def getNearestTime(no)
    bus_times = getTimeData('reverse', no)
    result = nil
    bus_times.each_with_index do |course_times, i|
      course_times.each_with_index do |course_time, j|
        unless isPast(course_time)
          return {
            time: course_time,
            index: [i, j]
          }
        end
      end
    end
  end
  
  def isPast(target_time)
    now = TimeHelper.new.now
    
    splited_time1 = [now.hour, now.min]
    splited_time2 = target_time.split(':')
  
    return (DateTime.now.change({hour: splited_time1[0], min: splited_time1[1]}) - DateTime.now.change({hour: splited_time2[0].to_i, min: splited_time2[1].to_i})).positive?
  end
  
end