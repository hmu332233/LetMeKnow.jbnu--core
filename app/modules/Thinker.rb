require 'JsonMaker'

class Thinker
  
  # def initialize
  #   @jsonMaker = JsonMaker.new
  #   @messageFactory = MessageFactory.new
  # end
  
  def think(message)

    # 도움말 메세지
    helpResult = thinkHelpMessage(message)
    unless helpResult.nil?
      return helpResult
    end
    
    # 이스터 에그
    easterEggResult = thinkEasterEgg(message)
    unless easterEggResult.nil?
      return easterEggResult
    end
    
    # 디비 추가 키워드
    addedMessageResult = thinkAddedMessage(message)
    unless addedMessageResult.nil?
      return addedMessageResult
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
  
  def thinkAddedMessage(message)
    jsonMaker = JsonMaker.new
    
    addedMessage = Message.findMessageBySentence(message)
    unless addedMessage.nil? 
      return jsonMaker.getMessageJson(addedMessage)
    else
      return nil
    end
  end
  
  def thinkEasterEgg(word)
    jsonMaker = JsonMaker.new
    
    result = nil
    alone_words = ["남친","여친","남자친구","여자친구"]
    alone_words.each do |alone_word|
        if word.include?alone_word
            result = ['태어나지 않았습니다','존재하지 않습니다','생길거같지 않습니다'].sample
        end
    end

    case word
    when "데이터삭제"
        result = "모든데이터가 삭제되었습니다"
        UserWord.delete_all
    when "반상민"
        start = Date.parse("22/04/2015")
        today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))

        result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
        result += "1500일 : " + (today.mjd - (start+1500).mjd + 1).to_s + "\n"
        result += "3년 : " + (today.mjd - Date.parse("22/04/2018").mjd + 1).to_s

    when "박도현"

        start = Date.parse("24/03/2016")
        today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))

        result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
        result += "800일 : " + (today.mjd - (start+800).mjd + 1).to_s + "\n"
        result += "2년 : " + (today.mjd - Date.parse("24/03/2018").mjd + 1).to_s

     when "연이웅이"
        start = Date.parse("01/05/2018")
        today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))

        result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
        result += "100일 : " + (today.mjd - (start+100).mjd + 1).to_s + "\n"
        result += "1년 : " + (today.mjd - Date.parse("01/05/2019").mjd + 1).to_s

    end

    unless result.nil?
      return jsonMaker.getMessageJson(result)
    else
      return nil
    end
  end
end