class ManagementController < ApplicationController
  def main
    @word_list = Word.order(count: :desc)
    @hit = Hit.all.first
  end

  def major
    @major_list = Major.all
  end

  def message
    @message_list = Message.all.reverse
  end
  
  def backup
    
    @backup_data = ManagementHelper.getDB
    
  end
  
  def setDB
    
    ManagementHelper.setDB(params[:data])
    redirect_to management_backup_path
    
  end
end
