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
            
            menu_all = 1
            if content.size >= 3
                if content[2] == "이번주"
                    menu_all = 0
                end
            end
            
            case content[1]
            when "학사공지"
                result = message_Manager.getMessage_Notice(0)
            when "일반공지"
                result = message_Manager.getMessage_Notice(1)
            when "교내채용"
                result = message_Manager.getMessage_Notice(2)
            when "특강"
                result = message_Manager.getMessage_Notice(3)
            when "스터디"
                result = message_Manager.getMessage_Notice(4)
            when "알바"
                result = message_Manager.getMessage_Notice(5)
            when "판매/구매"
                result = message_Manager.getMessage_Notice(6)
            when "자취"
                result = message_Manager.getMessage_Notice(7)
            when "분실물"
                result = message_Manager.getMessage_Notice(8)
                
                
            when "진수당" , "진수원"
                result = message_Manager.getJinsuMenu(dayNumber(day),menu_all)
            when "의대"
                result = message_Manager.getMediMenu(dayNumber(day),menu_all)
            when "학생회관"
                result = message_Manager.getStudentHallMenu(dayNumber(day),menu_all)
            when "도움말"
                result = "알려줘전북대의 사용방법 입니다\n\n\n공지사항 확인\n\n알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매/구매\n알려줘 자취\n알려줘 분실물\n\n\n학식 메뉴 확인\n\n알려줘 진수당(또는 진수원)\n알려줘 의대\n알려줘 학생회관\n\n- 뒤에 '이번주'를 붙이시면\n이번주 전체의 식단이 보입니다.\nex) 알려줘 학생회관 이번주"
            end
 
        end
        
        # testa = JBNU_Food_Parser.new
        
        # testa.requestMenu_hu
       
        # render json: {
        #         "message":{
        #             "text": "#{result}",
        #             "message_button": {
        #               "label": "주유 쿠폰받기",
        #               "url": "https://coupon/url"
        #             }
        #         },
        #         "keyboard": {
        #             "type": "buttons",
        #             "buttons": [
        #               "알려줘 학사공지",
        #               "다시 등록하기",
        #               "취소하기"
        #             ]
        #           }
        #     }
        
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
