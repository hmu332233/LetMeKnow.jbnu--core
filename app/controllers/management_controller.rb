require 'management/Tester'

class ManagementController < ApplicationController
  
  def monitoring
    
    tester = Tester.new("#{request.protocol}#{request.host_with_port}")
    tester.getTestResult

  end
  
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

