class ChatController < ApplicationController
  def keyboard
    render json: {
      "type": "text"
    }
  end

  def message
    
    message_content = params[:content]
    
    render json: {
      "message":{
        "text": "#{message_content}"
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
