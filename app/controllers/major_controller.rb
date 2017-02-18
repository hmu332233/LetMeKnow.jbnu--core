class MajorController < ApplicationController
  def create
    
     Message.create(message_params)
    
     redirect_to management_major
    
  end

  def update
  end

  def delete
  end
  
   
  def major_params
      return params.require(:major).permit(:name,:office,:tel,:fax)
   end
end
