require 'JBNU_Parser'
require 'JBNU_Food_Parser'

class Message_Manager
    
    def getMessage_Notice(board_id)
        return getMessage_Notice_Search(board_id,"")
    end
    
    def getMessage_Notice_Search(board_id,word)
    
        parser = JBNU_Parser.new
            
        posts = parser.getPosts(board_id,word)
        
        titles = ""
        posts.each do |post|
            titles += post.title.to_s.strip + "\n\n"
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
    
    def getDomitory(day,sw)
        
        if sw == 0
            return makeMenuText_domitory_all
        else
            return makeMenuText_domitory_day(day)
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
            content = "식단표가 제공되어 있지않습니다."
        else
            
            menu = menus[day]
        
            content = ""
            
            content += days[day] + "\n\n"
                
            if day == 0
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
                content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
                    
            else
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
                content += menu.breakfast[1] + "\n\n\n"
                content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
                content += menu.lunch[1] + "\n\n\n"
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
                
            if i == 0
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
                content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
                    
            else
                content += "아침" + "\n"
                content += menu.breakfast[0].split(":")[1] + "\n\n"
                content += menu.breakfast[1] + "\n\n\n"
                content += "점심" + "\n"
                content += menu.lunch[0].split(":")[1] + "\n\n"
                content += menu.lunch[1] + "\n\n\n"
                content += "저녁" + "\n"
                content += menu.dinner[0].split(":")[1] + "\n\n"
                content += menu.dinner[1] + "\n\n\n"
            end
            
            content += "\n"
        
        end
        
        
        return content.chop!.chop!.chop!
    end
    
end