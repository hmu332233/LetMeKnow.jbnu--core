require 'JsonMaker'

class Thinker
  
  # def initialize
  #   @jsonMaker = JsonMaker.new
  #   @messageFactory = MessageFactory.new
  # end
  
  def think(message)

    helpResult = thinkHelpMessage(message)
    unless helpResult.nil?
      return helpResult
    end
  end

  def thinkHelpMessage(message)
    jsonMaker = JsonMaker.new
    messageFactory = MessageFactory.new
    case message
    when "나가기"
      return jsonMaker.getMessageJson("감사합니다")      
    when "전체 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_all)
    when "학식 메뉴 확인 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_menu)
    when "공지사항 확인 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_notice)
    when "학과사무실 정보 확인 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_major)
    when "배달음식점 번호 확인 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_delivery)
    when "날씨 확인 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_weather)
    when "기타 키워드"
      return jsonMaker.getHelpMenuJson(messageFactory.makeMessage_help_etc)
    else
      return nil;
    end
  end
end