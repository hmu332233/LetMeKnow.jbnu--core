require 'extractor'
require 'JsonMaker'
require 'MessageFactory'
require 'Message_Manager'
require 'util/TimeHelper'

class ChatController < ApplicationController
  def keyboard
    render json: {
      "type": "text"
    }
  end

  def message
    
    timeHelper = TimeHelper.new
    messageFactory = MessageFactory.new
    message_Manager = Message_Manager.new
    jsonMaker = JsonMaker.new
    extractor = Extractor.new
    
    message_content = params[:content]
    
    #도움말 메세지
    case message_content
    when "나가기"
      render json: jsonMaker.getMessageJson("감사합니다")
      return;
    when "전체 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_all)
      return;
    when "학식 메뉴 확인 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_menu)
      return;
    when "공지사항 확인 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_notice)
      return;
    when "학과사무실 정보 확인 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_major)
      return;
    when "배달음식점 번호 확인 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_delivery)
      return;
    when "날씨 확인 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_weather)
      return;
    when "기타 키워드"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_etc)
      return;
    end
    
    #------------------------------------------------------------------------------------------------------------
    
    #문장 요소 추출
    extract_list = extractor.extract(message_content)
    
    entry = extract_list[0]
    intent = extract_list[1]
    subIntent = extract_list[2]
  
    #subIntent 처리
    case subIntent
    when "내일"
      day = timeHelper.dayOfWeek_Tomorrow
    when "모레"
      day = timeHelper.dayOfWeek_AfterTomprrow
    else
      day = timeHelper.dayOfWeek_Today
    end
    
    puts day
    puts "#{entry} : #{intent} : #{subIntent}"
    
  
    #의도 별 메세지 출력
    case entry
    when "학사공지"
      result = message_Manager.getMessage_Notice(0)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "일반공지"
      result = message_Manager.getMessage_Notice(1)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "교내채용"
      result = message_Manager.getMessage_Notice(2)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "특강"
      result = message_Manager.getMessage_Notice(3)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "스터디"
      result = message_Manager.getMessage_Notice(4)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "알바"
      result = message_Manager.getMessage_Notice(5)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "판매구매"
      result = message_Manager.getMessage_Notice(6)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "자취"
      result = message_Manager.getMessage_Notice(7)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
    when "분실물"
      result = message_Manager.getMessage_Notice(8)
      render json: jsonMaker.getMessageJson(result)
      return;
      #hit.notice_hits += 1
                
    when "진수"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_jinsu_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_jinsu_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
    when "의대"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_medi_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_medi_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
    when "학생회관"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_studentHall_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_studentHall_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
    when "후생관"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_hu_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_hu_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
    when "예지원"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_yeji_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_yeji_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
      
    when "참빛"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_Cham_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_Cham_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
    when "기존관" , "새빛" , "대동" , "평화", "한빛"
      case intent
      when nil , "학식"
        
        case subIntent
        when "이번주"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_Basic_all)
          return;
        else
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_Basic_day(dayNumber(day)))
          return;
        end
      when "시간"
          render json: jsonMaker.getMessageJson("여기에 시간 정보를 추가해 줄거야!")
          return;
      end
      #hit.domi_hits += 1
      
    when "치킨집"
      render json: jsonMaker.getMessageJson(message_Manager.getChikMessage)
      return;
      #hit.chik_hits += 1
    when "날씨"
      
      case subIntent
      when "내일"
        render json: jsonMaker.getMessageJson(message_Manager.getTomorrowWeatherMessage)
        return;
      when "모레"
        render json: jsonMaker.getMessageJson("모레 날씨 검색은 제공하고 있지않습니다.\n주간 날씨 검색을 이용해주세요.")
        return;
      when "주간","이번주"
        render json: jsonMaker.getMessageJson(message_Manager.makeWeekWeatherMessage)
        return;
      else
        render json: jsonMaker.getMessageJson(message_Manager.getTodayWeatherMessage)
        return;
      end
              
    when "도움말"
      render json: jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_basic)
      return;
      #hit.help_hits += 1
    end
  
  
    render json: {
      "message":{
        "text": "이 문구가 출력되면 안됩니다."
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


  def dayNumber(day)
    
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
    else
     result = 7
    end
        
    return result
  end
end
