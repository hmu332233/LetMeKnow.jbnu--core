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
    
    
    def getJinsuMenu
        return makeMenuTextAll(0)
    end
    
    def getJinsuMenu(day)
        return makeMenuTextDay(0,day)
    end
    
    def getMediMenu
        return makeMenuTextAll(1)
    end
    
    def getMediMenu(day)
        return makeMenuTextDay(1,day)
    end
    
    def getStudentHallMenu
        return makeMenuTextAll(2)
    end
    
    def getStudentHallMenu(day)
        return makeMenuTextDay(2,day)
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