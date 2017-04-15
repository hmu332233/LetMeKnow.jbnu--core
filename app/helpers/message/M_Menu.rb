require 'JBNU_Food_Parser'

module M_Menu
    
    #학식 모바일
    def makeMessage_jinsu_day(day)
        
        if day > 5 or day == 0
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
    
    
    def makeMessage_medi_day(day)
        
         if day > 5 or day == 0
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
    
    def makeMessage_studentHall_day(day)
        
        if day > 6 or day == 0
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
    
    def makeMessage_hu_day(day)
        
        if day > 5 or day == 0
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
    
    def makeMessage_yeji_day(day)
        
        if day > 5 or day == 0
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
    
    #이번주 메뉴
    def makeMessage_studentHall_all
        
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
    
    def makeMessage_hu_all
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMenu_hu
        
        contents = ""
        
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
    
    def makeMessage_yeji_all
        
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
    
    def makeMessage_jinsu_all
        return makeMessage_all(0)
    end
    
    def makeMessage_medi_all
        return makeMessage_all(1)
    end
    
    #진수 : 0
    #의대 : 1
    def makeMessage_all(id)
        
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
    
    
    def dayKor(day)
    
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
end