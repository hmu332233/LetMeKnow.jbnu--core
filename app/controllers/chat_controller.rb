require 'Extractor'
require 'JsonMaker'
require 'MessageFactory'
require 'Message_Manager'
require 'Thinker'
require 'util/TimeHelper'
require 'timeout'

class ChatController < ApplicationController
  def keyboard
    render json: {
      "type": "text"
    }
  end

  def message
    
    #시간 제한
    begin
      complete_results = Timeout.timeout(4.5) do      
       
        thinker = Thinker.new

        user_key = params[:user_key]
        message_content = params[:content]

        # new 사용량 측정용
        userWord = UserWord.create(user_key: user_key, content: message_content)

        #메세지 의도에 따른 결과
        resultJson = thinker.think(message_content)
        unless resultJson.nil?
          render json: resultJson
          return;
        end

        render json: {
          "message":{
            "text": "아직 이해하지 못하는 말이거나\n제공을 하고 있지 않는 기능입니다 (흑흑)\n\n'도움말'이라고 입력하시면\n자세한 사용방법을 알려드립니다."
          }
        }

      #시간제한
      end
    rescue Timeout::Error
      render json: {
      "message":{
        "text": "전북대학교 서버가 불안정하여\n정보를 가져오지 못하고 있습니다(흑흑)"
      }
    }
    return;
    end
  
    
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


  # def dayNumber(day)
    
  #   case day
  #   when 'Sunday'
  #     result = 0
  #   when 'Monday'
  #     result = 1
  #   when 'Tuesday'
  #     result = 2
  #   when 'Wednesday'
  #     result = 3
  #   when 'Thursday'
  #     result = 4
  #   when 'Friday'
  #     result = 5
  #   when 'Saturday'
  #     result = 6
  #   else
  #    result = 7
  #   end
        
  #   return result
  # end
  
  # def easterEgg(word)
        
  #       result = nil
        
  #       alone_words = ["남친","여친","남자친구","여자친구"]
        
  #       alone_words.each do |alone_word|
  #           if word.include?alone_word
  #               return ['태어나지 않았습니다','존재하지 않습니다','생길거같지 않습니다'].sample
  #           end
  #       end
       
  #       case word
  #       when "데이터삭제"
  #           result = "모든데이터가 삭제되었습니다"
  #           UserWord.delete_all
  #       when "반상민"
  #           start = Date.parse("22/04/2015")
  #           today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
  #           result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
  #           result += "1500일 : " + (today.mjd - (start+1500).mjd + 1).to_s + "\n"
  #           result += "3년 : " + (today.mjd - Date.parse("22/04/2018").mjd + 1).to_s
            
  #       when "박도현"
            
  #           start = Date.parse("24/03/2016")
  #           today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
  #           result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
  #           result += "800일 : " + (today.mjd - (start+800).mjd + 1).to_s + "\n"
  #           result += "2년 : " + (today.mjd - Date.parse("24/03/2018").mjd + 1).to_s
          
  #        when "연이웅이"
  #           start = Date.parse("01/05/2018")
  #           today = Date.parse((Time.now + (9*60*60)).strftime("%d/%m/%Y"))
            
  #           result = (today.mjd - start.mjd + 1).to_s + "일째 날입니다.\n"
  #           result += "100일 : " + (today.mjd - (start+100).mjd + 1).to_s + "\n"
  #           result += "1년 : " + (today.mjd - Date.parse("01/05/2019").mjd + 1).to_s
          
  #       end
       
  #       return result
        
  #   end
  
end
