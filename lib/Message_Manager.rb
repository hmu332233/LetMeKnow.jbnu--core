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
            return makeMenuTextAll(2)
        else
            return makeMenuTextDay(2,day)
        end
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
    
end