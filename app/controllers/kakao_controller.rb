require 'Message_Manager'
require 'JBNU_Food_Parser'

class KakaoController < ApplicationController
    
    def keyboard
        
        render json: {
            "type": "text"
        }
        
    end
    
    def message
     
        result="잘못된 명령어입니다. \n '알려줘 도움말' 을 입력하시면 자세한 사용방법을 알려드립니다"
        
        content = params[:content].split
        message_Manager = Message_Manager.new
        
        # if content[0] == "알려줘"
        #     if content[1] == "학사공지"
        #         result = message_Manager.getMessage_Notice(0)
        #     elsif content[1] == "알바"
        #         result = message_Manager.getMessage_Notice(5)
        #     end
        # end
        
        result = message_Manager.getStudentHallMenu
        
       
        
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
    
end
