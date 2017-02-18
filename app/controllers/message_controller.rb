class MessageController < ApplicationController
  def create
    
    Message.create(message_params)
    
    redirect_to management_message_path
    
  end

  def update
  end

  def delete
    Message.destroy(params[:id])
    redirect_to management_message_path
  end
  
  def message_params
      return params.require(:message).permit(:keyword,:content)
   end
end
