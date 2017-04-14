require 'Message_Manager'
require 'Datas'
require 'date'
require 'JsonMaker'
require 'kakao_helper'
require 'MessageFactory'
require 'util/TimeHelper'
class KakaoController < ApplicationController
    
    def keyboard
        
        render json: {
            "type": "text"
        }
        
    end
    
    def message
        
        messageFactory = MessageFactory.new
        
        message_content = params[:content]
        
        #사용량 측정
        hits = Hit.all
        hit = hits.find_or_create_by(name: "master")
        hit.connect_hits += 1
        
        words = Word.all
        word = words.find_or_create_by(content: message_content)
        word.count += 1
        word.save
        
        day = (Time.now + (9*60*60)).strftime("%A").to_s
     
        show_btn = false
        result="잘못된 명령어입니다. \n '알려줘 도움말' 을 입력하시면 자세한 사용방법을 알려드립니다"
        
        # content = params[:content].split(" ")
        message_Manager = Message_Manager.new
        jsonMaker = JsonMaker.new
        
        
        converted_message = converter(message_content)
        content = converted_message.split(" ")
        
        result = easterEgg(message_content,result)
        
        #----- 추가된 메세지
        addedMessage = Message.findMessageBySentence( message_content )
        unless addedMessage == nil 
            render json: {
                    "message":{
                        "text": "#{addedMessage}"
                    }
                }
            return;
        end
        #-----
        
        if content[0] == "알려줘"
            main_keyword = content[1]
            sub_keyword = content[2]
        else 
            main_keyword = content[0]
            sub_keyword = content[1]
        end
        
        if content[0] == "알려줘"
            
            menu_all = 1
            if sub_keyword == "이번주" || sub_keyword == "주간"
                menu_all = 0
            elsif sub_keyword == "내일"
                day = (Time.now + (9*60*60) + (24*60*60)).strftime("%A").to_s
            elsif sub_keyword == "모레"
                day = (Time.now + (9*60*60) + (2*(24*60*60))).strftime("%A").to_s
            end
            
            case main_keyword
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
                result = message_Manager.getYejiMessage(dayNumber(day),menu_all)
                hit.domi_hits += 1
            when "참빛"
                if menu_all == 1
                    result = messageFactory.makeMessage_Cham_day(dayNumber_domitory(day))
                else
                    result = messageFactory.makeMessage_Cham_all
                end
                # result = "전북대학교 기숙사 홈페이지 오류로 인해\n 현재 이용이 불가능합니다.\n이슈가 해결되는대로 복구하도록 하겠습니다."
                hit.domi_hits += 1
            when "기존관" , "새빛" , "대동" , "평화", "한빛"
                if menu_all == 1
                    result = messageFactory.makeMessage_Basic_day(dayNumber_domitory(day))
                else
                    result = messageFactory.makeMessage_Basic_all
                end
                # result = "전북대학교 기숙사 홈페이지 오류로 인해\n 현재 이용이 불가능합니다.\n이슈가 해결되는대로 복구하도록 하겠습니다."
                hit.domi_hits += 1
            when "치킨집"
                result = message_Manager.getChikMessage
                hit.chik_hits += 1
            # when "중국집"
            #     result = message_Manager.getChinaMessage
            #     hit.chik_hits += 1
                
            when "치킨몇마리" , "치킨"
                
                if sub_keyword.nil?
                    result = "치킨집 번호를 원하시면\n치킨집'이라고 입력해주세요!\n\n 치킨몇마리를 원하시면\n'알려줘 치킨몇마리 x명'이라고 입력해주세요!"
                else
                    result = message_Manager.makeMessageChiknum(sub_keyword.to_i)
                end

            when "과사"
                if content.size == 2
                    result = "검색할 학과를 입력해주세요.\n이름의 일부만 입력하셔도 검색해드립니다.\n\nex) \n소프트웨어공학과\n\n알려줘 과사 소프트\n알려줘 과사 소프트웨어공학과\n알려줘 과사 소프\n등등\n"
                else
                    result = message_Manager.getMajorMessage(sub_keyword)
                end
                hit.office_hits += 1
            # when "버스시간"
                
            #     result = "\n학교 근처 정류장 버스시간을 알려드립니다.\n\n하단의 버스정류장을 선택해주세요.\n\n알려줘 버스 [버스번호]\n알려줘 버정 [검색어]\n를 이용하면 직접 검색도 가능합니다.\n\n"
                
            #     render json: jsonMaker.getBusMenuJson(result)
            #     return;
                
            # when "버스"

            #     unless sub_keyword == nil
                
            #         result = "버스번호 '" + sub_keyword + "'를 검색한 결과입니다\n\n하단의 버스 확인을 눌러주세요"
            #         label = "버스 확인"
            #         url = Bus_Parser.new.getAddressBusNo(sub_keyword)
                
            #         render json: jsonMaker.getUrlBtnJson(result,label,url)
            #         return
            #     else
            #         result = "\n검색할 버스번호를 입력해주세요\n\n알려줘 버스 [번호]\n\nex)\n알려줘 버스 385\n알려줘 버스 165\n"
            #     end
                
            # when "버스정류장" , "버정"

            #     unless sub_keyword == nil
                
            #         result = "버스정류장 '" + sub_keyword + "'를 검색한 결과입니다\n\n하단의 버스 정류장 확인을 눌러주세요"
            #         label = "버스 정류장 확인"
            #         url = Bus_Parser.new.getAddressBusStop(sub_keyword)
                
            #         render json: jsonMaker.getUrlBtnJson(result,label,url)
            #         return
            #     else
            #         result = "\n검색할 정류장을 입력해주세요\n이름의 일부만 들어가도 검색이 가능합니다\n\n알려줘 버스정류장 [검색어]\n알려줘 버정 [검색어]\n\nex)\n알려줘 버스정류장 전북대\n알려줘 버정 동물원\n"
            #     end
                
            when "날씨"
                
                if sub_keyword == "내일"
                    result = message_Manager.getTomorrowWeatherMessage
                elsif sub_keyword == "주간" || sub_keyword == "이번주"
                    result = message_Manager.makeWeekWeatherMessage
                elsif sub_keyword == "모레"
                    result = "모레 날씨 검색은 제공하고 있지않습니다.\n주간 날씨 검색을 이용해주세요."
                else
                     result = message_Manager.getTodayWeatherMessage
                end
                
            when "도움말"
                
                show_btn = true
                
                help_message = "알려줘전북대는 키워드 입력방식으로 운영되고 있으며\n\n현재\n\n1. 학교 공지사항 확인\n2. 건지커뮤니티 글 확인\n3. 학식 메뉴 확인\n4. 학과사무실 정보 확인\n5. 날씨 확인\n\n등의 기능을 제공하고 있습니다\n하단의 버튼으로\n상세 키워드를 알려드립니다\n\n"
 
                result = "알려줘전북대의 사용방법 입니다\n\n\n" + help_message
                
                hit.help_hits += 1
                
            end
 
        end
        
        hit.save
        
        #선택해주세요 결과
        case converted_message
        when "학식 선택"
            result = "\n@ 어느 학식 메뉴를 알려드릴까요?\n\n후생관\n진수당\n예지원\n의대\n학생회관\n참빛관\n새빛관\n\n오늘 내일 모레 이번주\n  를 입력하시면 다른 날의 메뉴도 알려드립니다.\n\n ex)내일 진수당"
        when "기숙사 선택"
            result = "\n@ 어느 기숙사의 메뉴를 알려드릴까요?\n\n참빛관\n새빛관\n대동관\n평화관\n기존관\n\n오늘 내일 모레 이번주\n  를 입력하시면 다른 날의 메뉴도 알려드립니다.\n\nex)내일 참빛관"
        end
        
        
        # 버스 버튼에 따른 결과
        # results = busMessage(message_content)
        # if results[1]
        #     render json: jsonMaker.getBusMenuJson(results[0])
        #     return;
        # end
        
        # 도움말 버튼에 따른 결과
        notice_message = "공지사항 확인\n\n알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매구매\n알려줘 자취\n알려줘 분실물\n"
        menu_message = "@ 학식 메뉴 확인\n\n진수당(또는 진수원)\n예지원\n의대\n학생회관\n후생관\n참빛관\n새빛관(또는 기존관,대동관,평화관)\n\n오늘 내일 모레 이번주\n  를 입력하시면 다른 날의 메뉴도 알려드립니다.\n\nex)\n내일 참빛관\n이번주 진수당\n"
        delivery_message = "배달음식점 번호 확인\n\n알려줘 치킨집\n알려줘 중국집(기능 삭제)\n"
        major_message = "학과사무실 정보 확인\n\n\n알려줘 과사 [검색어]\n\n\n[검색어]에 검색하고 싶은 학과의 이름을 입력하세요.\n이름의 일부만 입력해도 검색이 가능합니다.\n\nex)\n소프트웨어공학과를 검색하고자 할 때\n\n알려줘 과사 소프트\n알려줘 과사 소프트웨어공학\n알려줘 과사 소프\n\n등등 \n모두 가능합니다.\n"
        
        all_message = "알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매구매\n알려줘 자취\n알려줘 분실물\n\n\n[추가 키워드 :  내일/이번주]\n알려줘 진수당(또는 진수원)\n알려줘 예지원\n알려줘 의대\n알려줘 학생회관\n알려줘 후생관\n알려줘 참빛관\n알려줘 새빛관(또는 기존관,대동관,평화관)\n\n알려줘 치킨집\n알려줘 중국집(기능삭제)\n\n알려줘 날씨\n알려줘 내일날씨\n알려줘 주간날씨\n\n알려줘 과사 [검색어]\n알려줘 치킨몇마리 [사람수]\n"
        # all_message = "알려줘 학사공지\n알려줘 일반공지\n알려줘 교내채용\n알려줘 특강\n알려줘 스터디\n알려줘 알바\n알려줘 판매구매\n알려줘 자취\n알려줘 분실물\n\n\n[추가 키워드 :  내일/이번주]\n알려줘 진수당(또는 진수원)\n알려줘 예지원\n알려줘 의대\n알려줘 학생회관\n알려줘 후생관\n알려줘 참빛관\n알려줘 새빛관(또는 기존관,대동관,평화관)\n\n알려줘 치킨집\n알려줘 중국집(기능삭제)\n\n알려줘 버스시간\n알려줘 버스 [버스번호]\n알려줘 버정 [검색어]\n\n알려줘 과사 [검색어]\n알려줘 치킨몇마리 [사람수]\n"
        
        
        case message_content
        when "나가기"
            result = "감사합니다"
        when "공지사항 확인 키워드"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + notice_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('notice.jpg')
        when "학식 메뉴 확인 키워드"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + menu_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('domi.jpg')
        when "배달음식점 번호 확인 키워드"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + delivery_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('chik.jpg')
        when "학과사무실 정보 확인 키워드"
            show_btn = true
            result = "\n" + major_message
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('office.jpg')
       when "날씨 확인 키워드"
            show_btn = true
            result = "\n<날씨 확인>\n\n알려줘 날씨\n알려줘 내일날씨\n알려줘 주간날씨\n\n정해진 형식 외에 자유롭게 물어봐도\n알려드립니다.\n\nex) \n내일 날씨 알려줘\n오늘날씨?\n\n\n자료제공 : 기상청"
            photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('weather.jpg')
       when "전체 키워드"
            show_btn = true
            result = "알려줘전북대의 사용방법 입니다\n\n\n" + "각각의 키워드는 세부기능이 존재하며 하단의 버튼으로 사용법을 확인할 수 있습니다.\n\n\n" + all_message
        when "기타 키워드"
            show_btn = true
            result = "\n기타 키워드 모음입니다.\n\n----------------------------------\n\n알려줘 치킨몇마리 [사람수]\n\n인원수를 입력했을때 \n피보나치 수열과 제켄도르프정리를 이용하여\n최적의 치킨마리수를 알려드립니다.\n\n이게 무슨말이냐구요? 저도 잘 모르겠습니다.\n\nex) \n알려줘 치킨몇마리 8명\n알려줘 치킨몇마리 5\n\n----------------------------------\n" 
        # when "버스, 버스정류장 확인 키워드"
        #     show_btn = true
        #     result = "\n<학교 주변 정거장 버스시간 확인>\n\n알려줘 버스시간\n\n\n<버스 검색>\n\n알려줘 버스 [버스번호]\nex)\n알려줘 버스 385\n\n\n<버스정류장 검색>\n\n알려줘 버정 [검색어]\n알려줘 버스정류장 [검색어]\nex)\n알려줘 버정 도청\n알려줘 버스정류장 도청\n"
        #     photo_url = "#{request.protocol}#{request.host_with_port}" + ActionController::Base.helpers.asset_path('bus.jpg')
        end
        
        #----테스트하는곳
        
        # result = converter(message_content)
        # result = message_Manager.makeMessageBusStop(1)
        # render json: JsonMaker.new.getBusMenuJson(result)
        # return;
        # result = message_Manager.makeMenuText_yeji_mobile(6)
        #---------------
        
         
        if show_btn
            if photo_url == nil
                render json: jsonMaker.getHelpMenuJson(result)
            else
                render json: jsonMaker.getHelpMenuPicJson(result,photo_url)
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
        when 'Saturday'
            result = 5
        else
           result = 6
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
    
    def easterEgg(word,_result)
        
        result = ""
        
        alone_words = ["남친","여친","남자친구","여자친구"]
        
        alone_words.each do |alone_word|
            if word.include?alone_word
                return ['태어나지 않았습니다','존재하지 않습니다','생길거같지 않습니다','그래도 결혼은 하겠죠?'].sample
            end
        end
       
        case word
        when "데이터ㅓ"
            result = Message_Manager.new.makeMessageData(true)
        when "데이터ㅏ"
            result = Message_Manager.new.makeMessageData(false)
        when "데이터삭제"
            result = "모든데이터가 삭제되었습니다"
            Word.delete_all
        when "사용량삭제"
            result = "사용량이 초기화되었습니다"
            Hit.delete_all
        when "사용량"
            result = Message_Manager.new.getHitsMessage
        when "반상민"
            start = Date.parse("22/04/2015")
            today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
            result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
            result += "700일 : " + (today.mjd - (start+700).mjd + 1).to_s + "\n"
            result += "2년 : " + (today.mjd - Date.parse("22/04/2017").mjd + 1).to_s
            
        when "박도현"
            
            start = Date.parse("24/03/2016")
            today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
            result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
            result += "500일 : " + (today.mjd - (start+500).mjd + 1).to_s + "\n"
            result += "1년 : " + (today.mjd - Date.parse("24/03/2017").mjd + 1).to_s
        else
            result = _result
        end
       
        return result
    end
    
    def converter(dialog)
        
        #도움말 
        if dialog.include?("키워드")
            return dialog
        end
        
        #학식
        if dialog.include?("학식")
            return "학식 선택"
        end
        
        #기숙사
        ect_keyword = %w[기숙사 긱사 생활관]
        
        ect_keyword.each do |ect_data|
            if dialog.include?(ect_data)
                return "기숙사 선택"
            end
        end
        
        convert = false
        
        main_keyword = ""
        sub_keyword = ""
        
        notice_keyword = %w[학사공지 일반공지 교내채용 특강 스터디 알바 판매구매 자취 분실물]
        food_keyword = %w[진수당 진수원 의대 학생회관 후생관 예지원 기존관 참빛 새빛 대동 평화 한빛]
        etc_keyword = %w[치킨집 날씨]
        sub_datas = %w[이번주 내일 주간 모레]
        
        
        
        main_datas = notice_keyword + food_keyword + etc_keyword
        
        main_datas.each do |main_data|
            
            if dialog.include?(main_data)
                main_keyword = main_data
                convert = true
            end
            
        end
        
        sub_datas.each do |sub_data|
            
            if dialog.include?(sub_data)
                sub_keyword = sub_data
            end
        end
        
        if convert
            return "알려줘 " + main_keyword + " " + sub_keyword
        else
            return dialog
        end
        
    end
    
    # def busMessage(message)
        
    #     id = -1
        
    #     case message
    #         when "전북대학교(농협앞)"
    #             id = 0
    #         when "전북대학교(덕진성당앞)"
    #             id = 3
    #         when "전북대학교(일양병원앞)"
    #             id = 4
    #         when "전북대학교(한나여성병원)"
    #             id = 5
    #         when "소방서(시청방향)"
    #             id = 2
    #         when "전북은행본점"
    #             id = 1
    #     end
        
    #     if id == -1
    #         result = message
    #         busMessage_sw = false
    #     else
    #         result = Message_Manager.new.makeMessageBusStop(id)
    #         busMessage_sw = true
    #     end
        
    #     return result,busMessage_sw
    # end
    
end
