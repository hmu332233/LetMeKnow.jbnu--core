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
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestJinsu
        
        head_text = "진수원(진수당)" + "\n\n\n"
        contents = ""
        
        menus.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return head_text + contents.to_s.chop!.chop!.chop!
        
    end
    
    def getMediMenu
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestMediMenu
        
        head_text = "의대" + "\n\n\n"
        contents = ""
        
        menus.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return head_text + contents.to_s.chop!.chop!.chop!
        
    end
    
    def getStudentHallMenu
        
        parser = JBNU_Food_Parser.new
        menus = parser.requestStudentHallMenu
        
        head_text = "학생회관" + "\n\n\n"
        contents = ""
        
        menus.each do |menu|
            text = menu.week + "(" + menu.time + ") - " + menu.category+"\n\n"
            menu.contents.each do |m|
                text += m + "\n"
            end
            
            contents += text + "\n\n"
        end
        
        return head_text + contents.to_s.chop!.chop!.chop!
    end

    
end