require 'JBNU_Parser'
require 'JBNU_Food_Parser'
require 'Weather_Parser'
require 'Bus_Parser'
require 'Datas'
require 'NilChecker'

class Message_Manager
    
    def getMessage_Notice(board_id)
        return getMessage_Notice_Search(board_id,"")
    end
    
    def getMessage_Notice_Search(board_id,word)
    
        parser = JBNU_Parser.new
            
        posts = parser.getPosts(board_id,word)
        
        main_link = "http://www.chonbuk.ac.kr"
        
        titles = ""
        posts.each do |post|
            titles += post.number + "\n"
            titles += post.title.to_s.strip + "\n"
            titles += post.period + "\n"
            titles += ("https://www.jbnu.ac.kr/kor/" + post.link).to_s + "\n\n"
        end
        
        return titles.to_s
    end
    
    def getJinsuMenu(day,sw)
        
        if sw == 0
            return makeMenuTextAll(0)
        else
            return makeMenuText_jinsu_mobile(day+1)
            # return makeMenuTextDay(0,day)
        end
       
    end
    
 
    def getMediMenu(day,sw)
        
        if sw == 0
            return makeMenuTextAll(1)
        else
            return makeMenuText_medi_mobile(day+1)
            # return makeMenuTextDay(1,day)
        end
    end
    
    
    def getStudentHallMenu(day,sw)
        
        if sw == 0
            return makeMenuText_studentHall_all
        else
            return makeMenuText_studentHall_mobile(day+1)
            # return makeMenuText_studentHall_day(day)
        end
    end
    
    def getHu(day,sw)
        
        if sw == 0
            return makeMenuText_hu_all
        else
            return makeMenuText_hu_mobile(day+1)
            # return makeMenuText_hu_day(day)
        end
    end
    
    def getDomitory(day,sw)
        
        if sw == 0
            return makeMenuText_domitory_all
        else
            return makeMenuText_domitory_day(day)
        end
    end
    
    def getDomitory2(day,sw)
        
        if sw == 0
            return makeMenuText_domitory2_all
        else
            return makeMenuText_domitory2_day(day)
        end
    end
    
    def getYejiMessage(day,sw)
        
        if sw == 0
            return getYejiMessage_all
        else
            return makeMenuText_yeji_mobile(day+1)
            # return getYejiMessage_day(day)
        end
        
    end
    
    def makeMenuText_studentHall_all
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestStudentHall
        
         # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
        
        menus.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
        
    end
    
     def makeMenuText_studentHall_day(day)
        
        if day == 5
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestStudentHall
        
        # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
        
        menus_day = [menus[day],menus[day+5]]
        
        menus_day.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
    end
    

    def makeMenuTextAll(id)
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu(id)
        
        # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
        
        menus.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
    end
    
    def makeMenuTextDay(id,day)
        
        if day == 5
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu(id)
        
        # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
        
        menus_day = [menus[day],menus[day+5]]
        
        menus_day.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
    end
    
    def makeMenuText_domitory_day(day)
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_domitory
        
        days = %w[일 월 화 수 목 금 토]
        
        if day >= menus.size
            content = "등록된 식단이 없습니다."
            return content
        else
            
            menu = menus[day]
        
            content = ""
            
            content += days[day] + "\n\n"
                
            # if day == 0 || day == 6
            #     content += "아침" + "\n"
            #     content += menu.breakfast[0].split(":")[1] + "\n\n"
            #     content += "점심" + "\n"
            #     content += menu.lunch[0].split(":")[1] + "\n\n"
            #     content += "저녁" + "\n"
            #     content += menu.dinner[0].split(":")[1] + "\n\n"
                    
            # else
            #     content += "아침" + "\n"
            #     content += menu.breakfast[0].split(":")[1] + "\n\n"
            #     content += menu.breakfast[1] + "\n\n\n"
            #     content += "점심" + "\n"
            #     content += menu.lunch[0].split(":")[1] + "\n\n"
            #     content += menu.lunch[1] + "\n\n\n"
            #     content += "저녁" + "\n"
            #     content += menu.dinner[0].split(":")[1] + "\n\n"
            #     content += menu.dinner[1] + "\n\n\n"
            # end
            
            if menu.breakfast.size == 1
                content += "아침" + "\n\n"
                content += makeMessageDomiSplit(menu.breakfast[0].split(":")[1]) + "\n\n"
            else
                content += "아침" + "\n\n"
                content += makeMessageDomiSplit(menu.breakfast[0].split(":")[1]) + "\n\n"
                content += makeMessageDomiSplit(menu.breakfast[1]) + "\n\n\n"
            end
            
            if menu.lunch.size == 1
                content += "점심" + "\n\n"
                content += makeMessageDomiSplit(menu.lunch[0].split(":")[1]) + "\n\n"
            else
                 content += "점심" + "\n\n"
                content += makeMessageDomiSplit(menu.lunch[0].split(":")[1]) + "\n\n"
                content += makeMessageDomiSplit(menu.lunch[1]) + "\n\n\n"
            end
            
            if menu.dinner.size == 1
                content += "저녁" + "\n\n"
                content += makeMessageDomiSplit(menu.dinner[0].split(":")[1]) + "\n\n"
            else
                content += "저녁" + "\n\n"
                content += makeMessageDomiSplit(menu.dinner[0].split(":")[1]) + "\n\n"
                content += makeMessageDomiSplit(menu.dinner[1]) + "\n\n\n"
            end

            
        end
        
            
        return content.chop!.chop!.chop!
    end
    
    def makeMenuText_domitory_all
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_domitory
        
        days = %w[일 월 화 수 목 금 토]
        
        content = ""
        menus.each_with_index do |menu,i|
            
            content += days[i] + "\n\n"
                
            # if i == 0 || i == 6
            #     content += "아침" + "\n"
            #     content += menu.breakfast[0].split(":")[1] + "\n\n"
            #     content += "점심" + "\n"
            #     content += menu.lunch[0].split(":")[1] + "\n\n"
            #     content += "저녁" + "\n"
            #     content += menu.dinner[0].split(":")[1] + "\n\n"
                    
            # else
            #     content += "아침" + "\n"
            #     content += menu.breakfast[0].split(":")[1] + "\n\n"
            #     content += menu.breakfast[1] + "\n\n\n"
            #     content += "점심" + "\n"
            #     content += menu.lunch[0].split(":")[1] + "\n\n"
            #     content += menu.lunch[1] + "\n\n\n"
            #     content += "저녁" + "\n"
            #     content += menu.dinner[0].split(":")[1] + "\n\n"
            #     content += menu.dinner[1] + "\n\n\n"
            # end
            
            if menu.breakfast.size == 1
                content += "아침" + "\n\n"
                content += makeMessageDomiSplit(menu.breakfast[0].split(":")[1]) + "\n\n"
            else
                content += "아침" + "\n\n"
                content += makeMessageDomiSplit(menu.breakfast[0].split(":")[1]) + "\n\n"
                content += makeMessageDomiSplit(menu.breakfast[1]) + "\n\n\n"
            end
            
            if menu.lunch.size == 1
                content += "점심" + "\n\n"
                content += makeMessageDomiSplit(menu.lunch[0].split(":")[1]) + "\n\n"
            else
                # content += "점심" + "\n"
                # content += menu.lunch[0].split(":")[1] + "\n\n"
                # content += menu.lunch[1] + "\n\n\n"
                
                content += "점심" + "\n\n"
                
                content += makeMessageDomiSplit(menu.lunch[0].split(":")[1]) + "\n\n"
                content += makeMessageDomiSplit(menu.lunch[1]) + "\n\n\n"
              
                
            end
            
            if menu.dinner.size == 1
                content += "저녁" + "\n\n"
                content += makeMessageDomiSplit(menu.dinner[0].split(":")[1]) + "\n\n"
            else
                content += "저녁" + "\n\n"
                content += makeMessageDomiSplit(menu.dinner[0].split(":")[1]) + "\n\n"
                content += makeMessageDomiSplit(menu.dinner[1]) + "\n\n\n"
            end
                
            
            
            content += "\n"
        
        end
        
        
        return content.chop!.chop!.chop!
    end
    
    def makeMenuText_domitory2_day(day)
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_domitory2
        
        days = %w[월 화 수 목 금]
        
        if day >= menus.size
            content = "등록된 식단이 없습니다.\n"
        else
            
            menu = menus[day]
        
            content = ""
            
            content += days[day] + "\n\n"
                
            content += "아침" + "\n\n"
            content += makeMessageDomiSplit2(menu.breakfast[0].split(": ")[1]) + "\n\n"
            content += "점심" + "\n\n"
            content += makeMessageDomiSplit2(menu.lunch[0].split(": ")[1]) + "\n\n"
            content += "저녁" + "\n\n"
            content += makeMessageDomiSplit2(menu.dinner[0].split(": ")[1]) + "\n\n"
                    
         
            
        end
        
            
        return content.chop!.chop!
    end
    
    def makeMenuText_domitory2_all
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_domitory2
        
        days = %w[월 화 수 목 금]
        
        content = ""
        menus.each_with_index do |menu,i|
            
            content += days[i] + "\n\n"
                
            
            content += "아침" + "\n\n"
            content += makeMessageDomiSplit2(menu.breakfast[0].split(": ")[1]) + "\n\n"
            content += "점심" + "\n\n"
            content += makeMessageDomiSplit2(menu.lunch[0].split(": ")[1]) + "\n\n"
            content += "저녁" + "\n\n"
            content += makeMessageDomiSplit2(menu.dinner[0].split(": ")[1]) + "\n\n"
          
            
            content += "\n"
        
        end
        
        
        return content.chop!.chop!
    end
    
     def makeMenuText_hu_all
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_hu
        
        
        contents = ""
        
        # menus.each do |menu|
        #     text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
        #     menu.contents.each do |m|
        #         text += m + "\n"
        #     end
            
        #     contents += text + "\n\n"
        # end
        i = 0
        while i < menus.size
        
            contents += menus[i].week + "(" + menus[i].time + ")"+"\n\n"
            contents += menus[i].category + " : " + menus[i].contents[0] + "\n"
            contents += menus[i+1].category + " : " + menus[i+1].contents[0] + "\n"
            contents += "\n"
            contents += menus[i+2].category + ":" + "\n\n"
            menus[i+2].contents.each do |con|
                contents += con + "\n"
            end
            
            contents += "\n\n"
            
            contents += menus[i+3].week + "(" + menus[i+3].time + ") - " + menus[i+3].category+"\n\n"
            menus[i+3].contents.each do |con|
                contents += con + "\n"
            end
            
            contents += "\n\n\n"
            
            i += 4
        end
        
        return contents.to_s.chop!.chop!.chop!.chop!
        
    end
    
    def makeMenuText_hu_day(day)
        
        if day == 5
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_hu
        
        
        contents = ""
        
        # menus.each do |menu|
        #     text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
        #     menu.contents.each do |m|
        #         text += m + "\n"
        #     end
            
        #     contents += text + "\n\n"
        # end
        i = day*4
       
        
        contents += menus[i].week + "(" + menus[i].time + ")"+"\n\n"
        contents += menus[i].category + " : " + menus[i].contents[0] + "\n"
        contents += menus[i+1].category + " : " + menus[i+1].contents[0] + "\n"
        contents += "\n"
        contents += menus[i+2].category + ":" + "\n\n"
        menus[i+2].contents.each do |con|
            contents += con + "\n"
        end
        
        contents += "\n\n"
        
        contents += menus[i+3].week + "(" + menus[i+3].time + ") - " + menus[i+3].category+"\n\n"
        menus[i+3].contents.each do |con|
            contents += con + "\n"
        end
        
        return contents.to_s.chop!
        
    end
    
    def getYejiMessage_all
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestYeji
        
        contents = ""
        
        menus.each do |menu|
            
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
            
        end
        
        return contents.chop!
    end
    
    def getYejiMessage_day(day)
        
        if day == 5
            return "주말에는 운영하지 않습니다"
        end
        
        i = day*2
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestYeji
        menus_m = [menus[i],menus[i+1]]
            
        contents = ""
        
        menus_m.each do |menu|
            
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
            
        end
        
        
        return contents.chop!
    end
    
    def getChikMessage
        
        result = ""
        
        datas = Datas.new
        
        chik = datas.getChick
        
        chik.each do |c|
            result += c[0] + "\n"
            result += c[1] + "\n\n"
        end
        
        
        return result
    end
    
    
    def getChinaMessage
        
        result = ""
        
        datas = Datas.new
        
        chik = datas.getChina
        
        chik.each do |c|
            result += c[0] + "\n"
            result += c[1] + "\n\n"
        end
        
        
        return result
    end
    
    
    def getMajorMessage(word)

        result_majors = Major.findByName(word)
        
        result = ""
        
        result_majors.each do |major|
            
            result += major.name + "\n\n"
            result += major.office + "\n"
            result += major.tel + "\n"
            result += NilChecker.checkNilAndReturnString(major.fax) + "\n\n\n"
            
        end
        
        if result == ""
            result = "검색결과가 없습니다.\n\n"
        end
        return result.chop!.chop!
        
    end
    
    
    def getHitsMessage
        
        hits = Hit.all
        hit = hits.find_or_create_by(name: "master")
        
        result = ""
        
        result += "알려줘 전북대 사용량\n\n"
        result += "접속 : " + hit.connect_hits.to_s + "\n\n"
        result += "전체 : " + hit.all_hits.to_s + "\n"
        result += "공지 : " + hit.notice_hits.to_s + "\n"
        result += "학식 : " + hit.domi_hits.to_s + "\n"
        result += "과사 : " + hit.office_hits.to_s + "\n"
        result += "치킨 : " + hit.chik_hits.to_s + "\n"
        result += "도움말 : " + hit.help_hits.to_s + "\n\n"
        
        return result
    end
    
    
    
    def makeMessageDomiSplit(menu_data)
        
        content = ""
        
        menu_data.split(",").each_with_index do |lunch_d,i|
            
            if i == 0
                tmp = lunch_d.split(")")
                
                unless tmp.size == 1
                    content += tmp[0].strip + ")" + "\n"
                    content += tmp[1] + "\n"
                else
                    content += lunch_d + "\n"
                end
            else
                content += lunch_d + "\n"
            end
            

        end
        
        return content.chop!
    end
    
    def makeMessageDomiSplit2(menu_data)
        
        content = ""
        
        menu_data.split(",").each_with_index do |lunch_d,i|
            
            content += lunch_d.strip + "\n"
    
        end
        
        return content.chop!
    end
    
    def makeMessageChiknum(people_num)
        
        if people_num > 100
            return "101명 이상은 지원하지 않는다네"
        else
            result = Datas.new.getChikNum(people_num-1).split(": ")[1]
            result += "마리를 시키면 될 것이야!"
            return result
        end

    end
    
    def makeMessageData(sw)
        
        if sw
            words = Word.order(:content)
        else
            words = Word.order(count: :desc)
        end
        
        result = "\n"
        words.each do |word|
            result += word.content
            result += " : "
            result += word.count.to_s
            result += "\n"
        end
        
        return result
            
    end

    # def makeMessageBusStop(id)
        
    #     buses = Bus_Parser.new.getSelectedBusStop(id).reverse
        
    #     result = ""
        
    #     if buses.length == 0
    #         result += "도착예정 버스가 없습니다"
    #     else
    #         buses.each do |bus|
    #             result += "\n"+bus.number + "\n"
    #             result += "남은정거장 : " + bus.remain_busstop_num
    #             result += "\t(" + bus.arrive_time.to_s + "분전)" + "\n"
    #             result += "최근통과지점 : " + bus.lately_busstop + "\n"
    #             result +=  "---\n"
    #         end
    #     end
        
    #     return result
    # end
    
    #날씨
    def getTodayWeatherMessage
        return makeWeatherMessage(0)
    end
    
    def getTomorrowWeatherMessage
        return makeWeatherMessage(1)
    end
    
    def makeWeatherMessage(day)
        
        weathers = Weather_Parser.new.getTodayWeather
        
        if day.to_s == "0"
            tmx = weathers.first.tmx
            tmn = weathers.first.tmn
            day_string = "오늘"
        elsif day.to_s == "1"
            # tmx = weathers.find(day: 1).first.tmx
            tomorrows = weathers.find {|s| s.day == "1" }
            tmx = tomorrows.tmx
            tmn = tomorrows.tmn
            day_string = "내일"
        end
        
        result_head = "\n"
        result_head += "덕진구 " + day_string + " 날씨입니다.\n\n\n"
        
        if day_string == "내일"
            result_head.chop!
            result_head += "최고 : " + tmx + "\n"
            result_head += "최저 : " + tmn + "\n\n"
        end
        

        result_body = ""
        
        weathers.each do |weather|
            
            if weather.day.to_s == day.to_s
                
                wfKor = weather.wfKor

                # 이모티콘

                # result += weather.day + "\n"
                result_body += weather.hour + "시 : "
                result_body += weather.temp + "도\n"
                result_body += wfKor
                result_body += " (강수확률 : " + weather.pop + "% )\n"
                result_body += "\n"
               
            end
            
        end
        
        if result_body == ""
            result_body = "날짜 갱신 중입니다.\n내일 날씨 검색을 이용해주세요\n\n"
        end
        
        result = result_head + result_body
        
        return result.chop!
    end
    
    def makeWeekWeatherMessage
        
        result = "\n"
        result += "전주 주간 날씨입니다.\n\n"
        
        weathers = Weather_Parser.new.getWeekDayWeather
  
        result = ""
        weathers.each do |weather|
            
            # 요일 계산 연산
            if weather.day.split(" ")[1] == "00:00"
                time = "오전"
            else 
                time = "오후"
            end
            
            wfKor = weather.wfKor
            
            if time == "오전"
                day_s = weather.day.split(" ")[0]
                ymd = day_s.split("-")
                dmy = Date.parse(ymd[2]+"/"+ymd[1]+"/"+ymd[0])
                dayOfWeek = dmy.strftime('%A')
              
                result += day_s + " " + dayKor(dayOfWeek) + "\n"
                result += "최저/최고 : "
                result += weather.tmn + "/" + weather.tmx + "\n"
                result += wfKor + "\n\n"
            elsif time == "오후"
                result.chop!.chop!
                result += " → " + wfKor
                result += "\n\n"
            end
     
        end
        
        return result.chop!
    end
    
    def dayKor(day)
    
        case day
        when 'Monday'
            result = "( 월 )"
        when 'Tuesday'
            result = "( 화 )"
        when 'Wednesday'
            result = "( 수 )"
        when 'Thursday'
            result = "( 목 )"
        when 'Friday'
            result = "( 금 )"
        when 'Saturday'
            result = "( 토 )"
        when 'Sunday'
            result = "( 일 )"
        end
        
        case day
        when 1
            result = "월"
        when 2
            result = "화"
        when 3
            result = "수"
        when 4
            result = "목"
        when 5
            result = "금"
        when 6
            result = "토"
        end
        
        return result
    end
    
    
    #학식 모바일
    def makeMenuText_jinsu_mobile(day)
        
        if day > 5
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_jinsu_mobile(day)
        
        # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
    
        menus.each do |menu|
            text = dayKor(menu.week) + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
        
    end
    
    
    def makeMenuText_medi_mobile(day)
        
         if day > 5
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_medi_mobile(day)
        
        # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
    
        menus.each do |menu|
            text = dayKor(menu.week) + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
        
    end
    
    def makeMenuText_studentHall_mobile(day)
        
        if day > 6
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_studentHall_mobile(day)
        
        # head_text = menus[0].shop_name + "\n\n\n"
        contents = ""
   
        menus.each do |menu|
            text = dayKor(menu.week) + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return contents.to_s.chop!.chop!.chop!
    end
    
    def makeMenuText_hu_mobile(day)
        
        if day > 5
            return "주말에는 운영하지 않습니다"
        end
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_hu_mobile(day)
        
        
        contents = ""
        
        i = 0

        contents += dayKor(menus[i].week) + "(" + menus[i].time + ")"+"\n\n"
        contents += menus[i].category + " : " + menus[i].contents[0] + "\n"
        contents += menus[i+1].category + " : " + menus[i+1].contents[0] + "\n"
        contents += menus[i+4].category + " : " + menus[i+4].contents[0] + "\n"
        contents += "\n"
        contents += menus[i+2].category + ":" + "\n\n"
        menus[i+2].contents.each do |con|
            contents += con + "\n"
        end
        
        contents += "\n\n"
        
        contents += dayKor(menus[i+3].week) + "(" + menus[i+3].time + ") - " + menus[i+3].category+"\n\n"
        menus[i+3].contents.each do |con|
            contents += con + "\n"
        end
        
        return contents.to_s.chop!
        
    end
    
    def makeMenuText_yeji_mobile(day)
        
        if day > 5
            return "주말에는 운영하지 않습니다"
        end
       
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_yeji_mobile(day)
       
        contents = ""
        
        menus.each do |menu|
            
            text = dayKor(menu.week) + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
            
        end
        
        return contents.chop!
        
    end
end