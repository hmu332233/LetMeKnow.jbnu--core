require 'Message_Manager'
require 'JBNU_Food_Parser'

class KakaoController < ApplicationController
    
    def keyboard
        
        render json: {
            "type": "text"
        }
        
    end
    
    def message
        
        day = Time.now.strftime("%A").to_s
     
        result="잘못된 명령어입니다. \n '알려줘 도움말' 을 입력하시면 자세한 사용방법을 알려드립니다"
        
        content = params[:content].split
        message_Manager = Message_Manager.new
        
        if content[0] == "알려줘"
            if content[1] == "학사공지"
                result = message_Manager.getMessage_Notice(0)
            elsif content[1] == "알바"
                result = message_Manager.getMessage_Notice(5)
            elsif content[1] == "진수당" || content[1] == "진수원"
                result = message_Manager.getJinsuMenu(dayNumber(day))
            elsif content[1] == "의대"
                result = message_Manager.getMediMenu(dayNumber(day))
            elsif content[1] == "학생회관"
                result = message_Manager.getStudentHallMenu(dayNumber(day))
            end
        end
        
            
     
        
    
       
        render json: {
                "message":{
                    "text": "#{result}"
                }
            }

    end
    
    def friend
        render json: ""
    end
    
    def friend2
        render json: ""
    end
    
    def chat_room
        render json: ""
    end


    def dayNumber(day)
    
        case day
        when 'Monday'
            result = 0
        when 'Tuesday'
            result = 1
        when 'Wednesday'
            result = 2
        when 'Thursday'
            result = 3
        when 'Friday'
            result = 4
        else
           result = 5
        end
        
        return result
    end
    
end
