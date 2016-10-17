require 'Message_Manager'
require 'JBNU_Food_Parser'
require 'Datas'
require 'Parser'
require 'date'
class KakaoController < ApplicationController
    
    def keyboard
        
        render json: {
            "type": "text"
        }
        
    end
    
    def message
        
        #사용량 측정
        hits = Hit.all
        hit = hits.find_or_create_by(name: "master")
        
        hit.connect_hits += 1
        
        
        day = (Time.now + (9*60*60)).strftime("%A").to_s
     
        show_btn = false
        result="잘못된 명령어입니다. \n '알려줘 도움말' 을 입력하시면 자세한 사용방법을 알려드립니다"
        
        content = params[:content].split(" ")
        message_Manager = Message_Manager.new
        
        result = easterEgg(content,result)
        
        if content[0] == "알려줘"
            
            menu_all = 1
            if content.size >= 3
                if content[2] == "이번주"
                    menu_all = 0
                elsif content[2] == "내일"
                    day = (Time.now + (9*60*60) + (24*60*60)).strftime("%A").to_s
                end
            end
            
            case content[1]
            when "학사공지"
                result = message_Manager.getMessage_Notice(0)
                hit.notice_hits += 1
            when "일반공지"
                result = message_Manager.getMessage_Notice(1)
                hit.notice_hits += 1
            when "교내채용"
                result = message_Manager.getMessage_Notice(2)
                hit.notice_hits += 1
            when "특강"
                result = message_Manager.getMessage_Notice(3)
                hit.notice_hits += 1
            when "스터디"
                result = message_Manager.getMessage_Notice(4)
                hit.notice_hits += 1
            when "알바"
                result = message_Manager.getMessage_Notice(5)
                hit.notice_hits += 1
            when "판매구매"
                result = message_Manager.getMessage_Notice(6)
                hit.notice_hits += 1
            when "자취"
                result = message_Manager.getMessage_Notice(7)
                hit.notice_hits += 1
            when "분실물"
                result = message_Manager.getMessage_Notice(8)
                hit.notice_hits += 1
                
                
            when "진수당" , "진수원"
                result = message_Manager.getJinsuMenu(dayNumber(day),menu_all)
                hit.domi_hits += 1
            when "의대"
                result = message_Manager.getMediMenu(dayNumber(day),menu_all)
                hit.domi_hits += 1
            when "학생회관"
                result = message_Manager.getStudentHallMenu(dayNumber(day),menu_all)
                hit.domi_hits += 1
            when "후생관"
                result = message_Manager.getHu(dayNumber(day),menu_all)
                hit.domi_hits += 1
            when "예지원"
                result = Message_Manager.new.getYejiMessage(dayNumber(day),menu_all)
                hit.domi_hits += 1
            when "참빛관"
                result = message_Manager.getDomitory(dayNumber_domitory(day),menu_all)
                hit.domi_hits += 1
            when "기존관" , "새빛관" , "대동관" , "평화관"
                result = message_Manager.getDomitory2(dayNumber(day),menu_all)
                hit.domi_hits += 1
                
                
            when "치킨집"
                result = message_Manager.getChikMessage
                hit.chik_hits += 1
            when "중국집"
                result = message_Manager.getChinaMessage
                hit.chik_hits += 1
                
            when "치킨몇마리"
                result = message_Manager.makeMessageChiknum(content[2].to_i)

            when "과사"
                if content.size == 2
                    result = "검색할 학과를 입력해주세요.\n이름의 일부만 입력하셔도 검색해드립니다.\n\nex) \n소프트웨어공학과\n\n알려줘 과사 소프트\n알려줘 과사 소프트웨어공학과\n알려줘 과사 소프\n등등\n"
                else
                    result = message_Manager.getMajorMessage(content[2])
                end
                hit.office_hits += 1
                
                
            when "도움말"
                
                show_btn = true
                
                help_message = "알려줘전북대는 키워드 입력방식으로 운영되고 있으며\n\n현재\n\n1. 학교 공지사항 확인\n2. 건지커뮤니티 글 확인\n3. 학식 메뉴 확인\n4. 학과사무실 정보 확인\n5. 근처 치킨집, 중국집 번호 확인\n\n등의 기능을 제공하고 있습니다\n하단의 버튼으로\n상세 키워드를 알려드립니다\n\n"
 
                result = "알려줘전북대의 사용방법 입니다\n\n\n" + help_message
                
                hit.help_hits += 1
                
            end
 
        end
        
        hit.save
        
        
        notice_message = "공지사항 확인\n\n알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매구매\n알려줘 자취\n알려줘 분실물\n"
        menu_message = "학식 메뉴 확인\n\n알려줘 진수당(또는 진수원)\n알려줘 예지원\n알려줘 의대\n알려줘 학생회관\n알려줘 후생관\n알려줘 참빛관\n알려줘 새빛관(또는 기존관,대동관,평화관)\n\n- 뒤에 '이번주'를 붙이시면\n이번주 전체의 식단이 보입니다.\nex) 알려줘 진수당 이번주\n\n- 뒤에 '내일'을 붙이시면\n다음날의 식단을 확인 할 수 있습니다.\nex) 알려줘 진수당 내일\n"
        delivery_message = "배달음식점 번호 확인\n\n알려줘 치킨집\n알려줘 중국집\n"
        major_message = "학과사무실 정보 확인\n\n\n알려줘 과사 [검색어]\n\n\n[검색어]에 검색하고 싶은 학과의 이름을 입력하세요.\n이름의 일부만 입력해도 검색이 가능합니다.\n\nex)\n소프트웨어공학과\n\n알려줘 과사 소프트\n알려줘 과사 소프트웨어공학\n알려줘 과사 소프\n\n등등 \n모두 가능합니다.\n"
        
        
        all_message = "알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매구매\n알려줘 자취\n알려줘 분실물\n\n\n[추가 키워드 :  내일/이번주]\n알려줘 진수당(또는 진수원)\n알려줘 예지원\n알려줘 의대\n알려줘 학생회관\n알려줘 후생관\n알려줘 참빛관\n알려줘 새빛관(또는 기존관,대동관,평화관)\n\n\n알려줘 치킨집\n알려줘 중국집\n\n\n알려줘 과사 [검색어]\n"
        
        case content[0]
        when "도움말"
            result = "감사합니다"
        when "공지사항"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + notice_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('notice.jpg')
        when "학식"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + menu_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('domi.jpg')
        when "배달음식점"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + delivery_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('chik.jpg')
        when "학과사무실"
            show_btn = true
            result = "\n" + major_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('office.jpg')
        when "전체"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + "각각의 키워드는 세부기능이 존재하며 하단의 버튼으로 사용법을 확인할 수 있습니다.\n\n\n" + all_message
        end
        
        if show_btn
            
            if photo_url == nil
                render json: {
                "message":{
                    "text": "#{result}",
                },
                "keyboard": {
                    "type": "buttons",
                    "buttons": [
                        "도움말 종료",
                        "전체 키워드",
                        "학식 메뉴 확인 키워드",
                        "공지사항 확인 키워드",
                        "배달음식점 번호 확인 키워드",
                        "학과사무실 정보 확인 키워드"
                        ]
                    }
                }
                
            else
                
                render json: {
                "message":{
                    "text": "#{result}",
                    "photo": {
                        "url": photo_url,
                        "width": 960,
                        "height": 960
                    }
                },
                "keyboard": {
                    "type": "buttons",
                    "buttons": [
                        "도움말 종료",
                        "전체 키워드",
                        "학식 메뉴 확인 키워드",
                        "공지사항 확인 키워드",
                        "배달음식점 번호 확인 키워드",
                        "학과사무실 정보 확인 키워드"
                        ]
                    }
                }
                
            end
        else
            
            render json: {
                "message":{
                    "text": "#{result}"
                }
            }
            
        end
        
     
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
            when "사용량"
                result = Message_Manager.new.getHitsMessage
                
            when "박도현"
                
                start = Date.parse("24/03/2016")
                today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
                
                result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
                result += "300일 : " + (today.mjd - (start+300).mjd + 1).to_s + "\n"
                result += "1년 : " + (today.mjd - Date.parse("24/03/2017").mjd + 1).to_s
                
            when "쌍지은" , "허지은" , "신지은"
                result = "\n☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆\n☆\n☆   댄 ☆ 싱\n☆   머 ☆ 신\n☆\n☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆\n"
            when "전도사"
                result = "\n☆☆☆☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆☆☆☆\n☆\n☆ 14 식영 ☆ 두유현주\n☆ 14 소공 ☆ 아뱅지현\n☆\n☆☆☆☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆☆☆☆\n☆☆☆☆☆☆☆☆☆☆\n"
            when "만든이" , "개발자"
                result = "_CopyRight@ 소프트웨어공학과 mu"
            when "남친" , "여친" , "남자친구" , "여자친구"
                result = ["태어나지 않았습니다","태어날 예정입니다","존재하지 않습니다"].sample
            when "나래짓"
                result = "전북대 유일의 중앙 댄스동아리\n나래짓의 정기공연이\n11월 12일 토요일에\n구정문 삼각지에서 있을 예정입니다!"
            else
                result = _result
            end
            
            
        end
        
        return result
    end
    
end
