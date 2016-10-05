require 'JBNU_Parser'
require 'JBNU_Food_Parser'
require 'Datas'

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
            titles += ("http://www.chonbuk.ac.kr/bb/board.php?action=view&boardID="+post.category+"&SEQ="+ post.number.to_s.strip).to_s + "\n\n"
            titles.to_s
        end
        
        return titles
    end
    
    def getJinsuMenu(day,sw)
        
        if sw == 0
            return makeMenuTextAll(0)
        else
            return makeMenuTextDay(0,day)
        end
       
    end
    
 
    def getMediMenu(day,sw)
        
        if sw == 0
            return makeMenuTextAll(1)
        else
            return makeMenuTextDay(1,day)
        end
    end
    
    
    def getStudentHallMenu(day,sw)
        
        if sw == 0
            return makeMenuText_studentHall_all
        else
            return makeMenuText_studentHall_day(day)
        end
    end
    
    def getHu(day,sw)
        
        if sw == 0
            return makeMenuText_hu_all
        else
            return makeMenuText_hu_day(day)
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
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
            else
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
                content += menu.breakfast[1] + "\n\n\n"
            end
            
            if menu.lunch.size == 1
                content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
            else
                 content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
                content += menu.lunch[1] + "\n\n\n"
            end
            
            if menu.dinner.size == 1
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
            else
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
                content += menu.dinner[1] + "\n\n\n"
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
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
            else
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
                content += menu.breakfast[1] + "\n\n\n"
            end
            
            if menu.lunch.size == 1
                content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
            else
                 content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
                content += menu.lunch[1] + "\n\n\n"
            end
            
            if menu.dinner.size == 1
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
            else
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
                content += menu.dinner[1] + "\n\n\n"
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
                
            content += "아침" + "\n"
            content += menu.breakfast[0].split(": ")[1] + "\n\n"
            content += "점심" + "\n"
            content += menu.lunch[0].split(": ")[1] + "\n\n"
            content += "저녁" + "\n"
            content += menu.dinner[0].split(": ")[1] + "\n\n"
                    
         
            
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
                
            
            content += "아침" + "\n"
            content += menu.breakfast[0].split(": ")[1] + "\n\n"
            content += "점심" + "\n"
            content += menu.lunch[0].split(": ")[1] + "\n\n"
            content += "저녁" + "\n"
            content += menu.dinner[0].split(": ")[1] + "\n\n"
          
            
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
        
        result_majors = []
        
        majors = Datas.new.getMajors
        
        majors.each do |major|
            
            if major.name.include?word
                result_majors << major
            end
            
        end
        
        
        
        result = ""
        
        result_majors.each do |major|
            
            result += major.name + "\n\n"
            result += major.office + "\n"
            result += major.tel + "\n"
            result += major.fax + "\n\n"
            
        end
        
        if result == ""
            result = "검색결과가 없습니다."
        end
        return result
        
    end
    
end