class ManagementController < ApplicationController
  
  def monitoring
  end
  
  def main    
    @groupedWordsByContent = UserWord.group(:content).order('count_id desc', 'max(created_at) asc').count('id')
    @allRequestCount = @groupedWordsByContent.values.sum
  end
  
  def message_detail
    content = params[:content]
    @userWords = UserWord.where({content: content})
  end
  
  def user
    @groupedWordsByUserKey = UserWord.group(:user_key).order('count_id desc', 'max(created_at) asc').count('id')
  end
  
  def user_detail
    user_key = params[:user_key]
    @userWords = UserWord.where({ user_key: user_key })
  end

  def major
    @major_list = Major.all
  end
  
  def menu
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
  
  def sw_menu
    @sw = Sw.find(1)
    
    puts @sw.menu
    
    if @sw.menu == 0
      @sw.menu = 1
      @val = "모바일홈페이지"
    elsif @sw.menu == 1
      @sw.menu = 0
      @val = "학교홈페이지"
    end 
    
    @sw.save
  end
    
end

