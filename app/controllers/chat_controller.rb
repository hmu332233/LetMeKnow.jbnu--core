require 'Extractor'
require 'JsonMaker'
require 'MessageFactory'
require 'Message_Manager'
require 'Thinker'
require 'util/TimeHelper'
require 'util/NotifySender'
require 'timeout'
require 'ManagementApi'

class ChatController < ApplicationController
  def keyboard
    render json: {
      "type": "text"
    }
  end

  def message
   
    jsonMaker = JsonMaker.new
    # user_key = params[:user_key]
    # message_content = params[:content]
    
    user_key = params[:userRequest][:user][:id]
    message_content = params[:userRequest][:utterance]

    Thread.new do
      ManagementApi.sendUserWord(user_key, message_content)
    end
    
    #시간 제한
    begin
      complete_results = Timeout.timeout(4.5) do      
       
        thinker = Thinker.new

        # new 사용량 측정용
        userWord = UserWord.create(user_key: user_key, content: message_content)

        #메세지 의도에 따른 결과
        resultJson = thinker.think(message_content)
        unless resultJson.nil?
          render json: resultJson
          return;
        end

        render json: jsonMaker.getQuickRepliesJson("아직 이해하지 못하는 말이거나\n제공을 하고 있지 않는 기능입니다 (흑흑)\n\n 다음과 같이 입력해보시는건 어떨까요?", ["버스 위치", "이번주 참빛"])
        
      end
    rescue Timeout::Error
      NotifySender.new.send(" 시간초과\n\n메세지: #{message_content}\n유저: #{user_key}")
      # 시간제한 에러
      render json: jsonMaker.getMessageJson("전북대학교 서버가 불안정하여\n정보를 가져오지 못하고 있습니다(흑흑)")
      return;
    rescue NoMethodError
      # 식단 갱신 안될때 에러
      # FIXME:: 좀 더 확실한 에러를 잡아서 고치기
      NotifySender.new.send(" 식단 갱신\n\n메세지: #{message_content}\n유저: #{user_key}")
      DormitoryMenuDb.updateDormitoryMenu()
      render json: jsonMaker.getMessageJson("기숙사 식단을 업데이트 중입니다.(하하)\n\n3초 뒤 다시 시도해주세요.")
      return;
    rescue
      # 그 외 에러
      NotifySender.new.send(" 에러\n\n메세지: #{message_content}\n유저: #{user_key}")
      render json: jsonMaker.getMessageJson("(절규)(절규)\n예기치 못한 에러가 발생했습니다\n\n해당 에러는 리포팅 되었으며\n빠른 시일 내에 고치도록 하겠습니다.\n\n감사합니다.")
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
end
