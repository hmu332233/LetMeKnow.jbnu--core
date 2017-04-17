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
    
    #사용량 측정
    words = Word.all
    word = words.find_or_create_by(content: message_content)
    word.count += 1
    word.save
    
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
    
#-----------------------------------------------------------------------------------------------------
    
    #검색 -바꿀방법 찾기
    messages = message_content.split(" ")
    main_keyword = messages[1]
    sub_keyword = messages[2]
    
    case main_keyword
    when "치킨몇마리" , "치킨"
      if sub_keyword.nil?
        result = "치킨집 번호를 원하시면\n'치킨집'이라고 입력해주세요!\n\n 치킨몇마리를 원하시면\n'알려줘 치킨몇마리 x명'이라고 입력해주세요!"
        render json: jsonMaker.getMessageJson(result)
        return; 
      else
        result = message_Manager.makeMessageChiknum(sub_keyword.to_i)
        render json: jsonMaker.getMessageJson(result)
        return; 
      end

    when "과사"
      if sub_keyword.nil?
        result = "검색할 학과를 입력해주세요.\n이름의 일부만 입력하셔도 검색해드립니다.\n\nex) \n소프트웨어공학과\n\n알려줘 과사 소프트\n알려줘 과사 소프트웨어공학과\n알려줘 과사 소프\n등등\n"
        render json: jsonMaker.getMessageJson(result)
        return; 
      else
        result = message_Manager.getMajorMessage(sub_keyword)
        render json: jsonMaker.getMessageJson(result)
        return; 
      end
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
    
    # puts day
    # puts "#{entry} : #{intent} : #{subIntent}"
    
  
    #의도 별 메세지 출력
    case entry
    when nil
      case intent
      when "학식", "학생식당"
        result = "\n@ 어느 학식 메뉴를 알려드릴까요?\n\n후생관\n진수당\n예지원\n의대\n학생회관\n참빛관\n새빛관\n\n오늘 내일 모레 이번주\n  를 입력하시면 다른 날의 메뉴도 알려드립니다.\n\n ex)내일 진수당"
        render json: jsonMaker.getMessageJson(result)
        return;
      when "시간"
        result = "\n@ 어느 곳의 시간 정보를 알려드릴까요?\n\n후생관\n진수당\n예지원\n의대\n학생회관\n기숙사\n\nex)\n후생관 이용시간\n기숙사 통금시간"
        render json: jsonMaker.getMessageJson(result)
        return; 
      end
    when "기숙사","긱사","생활관"
      case intent
      when "시간"
        render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_dormitory_food + messageFactory.makeMessage_time_dormitory_limite)
        return;
      else
        result = "\n@ 어느 기숙사의 메뉴를 알려드릴까요?\n\n참빛관\n새빛관\n대동관\n평화관\n기존관\n\n오늘 내일 모레 이번주\n  를 입력하시면 다른 날의 메뉴도 알려드립니다.\n\nex)내일 참빛관"
        render json: jsonMaker.getMessageJson(result)
        return;
      end
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_jinsu)
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_medi)
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_studentHall)
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_hu)
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson("예지원은 현재 운영을 하지 않고 있습니다.")
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_dormitory_food + messageFactory.makeMessage_time_dormitory_limite)
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
      when "시간","언제"
          render json: jsonMaker.getMessageJson(messageFactory.makeMessage_time_dormitory_food + messageFactory.makeMessage_time_dormitory_limite)
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
    
    #---------------------------------------------------------------------------------------------------------
    
    #이스터 에그와 디비 추가 키워드
    
    egg_message = easterEgg(message_content)
    
    unless egg_message.nil?
      render json: jsonMaker.getMessageJson(egg_message)
      return; 
    end
    
    addedMessage = Message.findMessageBySentence( message_content )
    unless addedMessage.nil? 
      render json: jsonMaker.getMessageJson(addedMessage)
      return;
    end
    
    #------------------------------------------------------------------------------------------------------------
  
  
    render json: {
      "message":{
        "text": "아직 이해하지 못하는 말이거나\n제공을 하고 있지 않는 기능입니다 (흑흑)\n\n'도움말'이라고 입력하시면\n자세한 사용방법을 알려드립니다."
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
  
  def easterEgg(word)
        
        result = nil
        
        alone_words = ["남친","여친","남자친구","여자친구"]
        
        alone_words.each do |alone_word|
            if word.include?alone_word
                return ['태어나지 않았습니다','존재하지 않습니다','생길거같지 않습니다','그래도 결혼은 하겠죠?'].sample
            end
        end
       
        case word
        when "데이터삭제"
            result = "모든데이터가 삭제되었습니다"
            Word.delete_all
        when "반상민"
            start = Date.parse("22/04/2015")
            today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
            result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
            result += "800일 : " + (today.mjd - (start+800).mjd + 1).to_s + "\n"
            result += "2년 : " + (today.mjd - Date.parse("22/04/2017").mjd + 1).to_s
            
        when "박도현"
            
            start = Date.parse("24/03/2016")
            today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
            result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
            result += "500일 : " + (today.mjd - (start+500).mjd + 1).to_s + "\n"
            result += "2년 : " + (today.mjd - Date.parse("24/03/2018").mjd + 1).to_s
        end
       
        return result
        
    end
  
end
