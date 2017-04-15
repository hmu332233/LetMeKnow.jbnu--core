require 'extractor'
require 'JsonMaker'
require 'MessageFactory'
require 'Message_Manager'

class ChatController < ApplicationController
  def keyboard
    render json: {
      "type": "text"
    }
  end

  def message
    
    messageFactory = MessageFactory.new
    message_Manager = Message_Manager.new
    jsonMaker = JsonMaker.new
    
    message_content = params[:content]
    
    extractor = Extractor.new
    
    extract_list = extractor.extract(message_content)
    
    entry = extract_list[0]
    intent = extract_list[1]
    subIntent = extract_list[2]
  
    case entry
    when "학사공지"
      result = message_Manager.getMessage_Notice(0)
      render json: jsonMaker.getMessageJson("테스트입니다")
      return;
      #hit.notice_hits += 1
    when "일반공지"
      result = message_Manager.getMessage_Notice(1)
      #hit.notice_hits += 1
    when "교내채용"
      result = message_Manager.getMessage_Notice(2)
      #hit.notice_hits += 1
    when "특강"
      result = message_Manager.getMessage_Notice(3)
      #hit.notice_hits += 1
    when "스터디"
      result = message_Manager.getMessage_Notice(4)
      #hit.notice_hits += 1
    when "알바"
      result = message_Manager.getMessage_Notice(5)
      #hit.notice_hits += 1
    when "판매구매"
      result = message_Manager.getMessage_Notice(6)
      #hit.notice_hits += 1
    when "자취"
      result = message_Manager.getMessage_Notice(7)
      #hit.notice_hits += 1
    when "분실물"
      result = message_Manager.getMessage_Notice(8)
      #hit.notice_hits += 1
                
    when "진수"
      result = message_Manager.getJinsuMenu(dayNumber(day),menu_all)
      #hit.domi_hits += 1
    when "의대"
      result = message_Manager.getMediMenu(dayNumber(day),menu_all)
      #hit.domi_hits += 1
    when "학생회관"
      result = message_Manager.getStudentHallMenu(dayNumber(day),menu_all)
      #hit.domi_hits += 1
    when "후생관"
      result = message_Manager.getHu(dayNumber(day),menu_all)
      #hit.domi_hits += 1
    when "예지원"
      result = message_Manager.getYejiMessage(dayNumber(day),menu_all)
      #hit.domi_hits += 1
    when "참빛"
      if menu_all == 1
        result = messageFactory.makeMessage_Cham_day(dayNumber_domitory(day))
      else
        result = messageFactory.makeMessage_Cham_all
      end
      # result = "전북대학교 기숙사 홈페이지 오류로 인해\n 현재 이용이 불가능합니다.\n이슈가 해결되는대로 복구하도록 하겠습니다."
      #hit.domi_hits += 1
    when "기존관" , "새빛" , "대동" , "평화", "한빛"
      if menu_all == 1
        result = messageFactory.makeMessage_Basic_day(dayNumber_domitory(day))
      else
        result = messageFactory.makeMessage_Basic_all
      end
      # result = "전북대학교 기숙사 홈페이지 오류로 인해\n 현재 이용이 불가능합니다.\n이슈가 해결되는대로 복구하도록 하겠습니다."
      #hit.domi_hits += 1
    when "치킨집"
      result = message_Manager.getChikMessage
      #hit.chik_hits += 1

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
               
      #hit.help_hits += 1
                
    end
      
  
    # result = "#{entry} : #{intent} : #{subIntent}"
    
    render json: {
      "message":{
        "text": "#{result}"
      }
    }
    
  end

  def add_friend
    render json: ""
  end

  def delete_friend
    render json: ""
  end

  def chat_room
    render json: ""
  end


end
