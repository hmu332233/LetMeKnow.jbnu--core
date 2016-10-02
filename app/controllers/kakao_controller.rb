require 'Message_Manager'
require 'JBNU_Food_Parser'
require 'Datas'
class KakaoController < ApplicationController
    
    def keyboard
        
        render json: {
            "type": "text"
        }
        
    end
    
    def message
        
        day = (Time.now + (9*60*60)).strftime("%A").to_s
     
        result="잘못된 명령어입니다. \n '알려줘 도움말' 을 입력하시면 자세한 사용방법을 알려드립니다"
        
        content = params[:content].split(" ")
        message_Manager = Message_Manager.new
        
        result = easterEgg(content,result)
        
        if content[0] == "알려줘"
            
            menu_all = 1
            if content.size >= 3
                if content[2] == "이번주"
                    menu_all = 0
                else content[2] == "내일"
                    day = (Time.now + (9*60*60) + (24*60*60)).strftime("%A").to_s
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
            when "판매구매"
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
            when "후생관"
                result = message_Manager.getHu(dayNumber(day),menu_all)
            when "참빛관"
                result = message_Manager.getDomitory(dayNumber_domitory(day),menu_all)
            when "기존관" , "새빛관" , "대동관" , "평화관"
                result = message_Manager.getDomitory2(dayNumber(day),menu_all)
                
                
            when "치킨집"
                result = message_Manager.getChikMessage
            when "중국집"
                result = message_Manager.getChinaMessage
            
                
            when "도움말"
                result = "알려줘전북대의 사용방법 입니다\n\n\n공지사항 확인\n\n알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매구매\n알려줘 자취\n알려줘 분실물\n\n\n학식 메뉴 확인\n\n알려줘 진수당(또는 진수원)\n알려줘 의대\n알려줘 학생회관\n알려줘 후생관\n알려줘 참빛관\n알려줘 새빛관(또는 기존관,대동관,평화관)\n\n- 뒤에 '이번주'를 붙이시면\n이번주 전체의 식단이 보입니다.\nex) 알려줘 진수당 이번주\n\n- 뒤에 '내일'을 붙이시면\n다음날의 식단을 확인 할 수 있습니다.\nex) 알려줘 진수당 내일\n\n\n배달음식점 번호 확인\n\n알려줘 치킨집\n알려줘 중국집\n"
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
    
    
    def dayNumber_domitory(day)
    
        case day
        when 'Sunday'
           result = 0
        when 'Monday'
           result = 1
        when 'Tuesday'
           result = 2
        when 'Wednesday'
           result = 3
        when 'Thursday'
           result = 4
        when 'Friday'
           result = 5
        when 'Saturday'
           result = 6
        end
        
        return result
    end
    
    def easterEgg(contents,_result)
        
        result = ""
        
        contents.each do |con|
            
            case con
            when "만든이" , "개발자"
                result = "소프트웨어공학과 mu"
            when "남친" , "여친" , "남자친구" , "여자친구"
                result = ["태어나지 않았습니다","내일 태어날 예정입니다","존재하지 않습니다"].sample
            when "나래짓"
                result = "전북대 유일의 중앙 댄스동아리\n나래짓의 정기공연이\n11월 12일 토요일에\n구정문 삼각지에서 있을 예정입니다!"
            else
                result = _result
            end
            
            
        end
        
        return result
    end
    
end
