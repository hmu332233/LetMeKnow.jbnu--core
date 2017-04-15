class ManagementController < ApplicationController
  def main
    @word_list = Word.order(count: :desc)
    # @hit = Hit.all.first
    
    @call_size = 0
    @word_list.each do |word|
      @call_size += word.count
    end
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
