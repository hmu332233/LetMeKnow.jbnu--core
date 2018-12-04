require 'saver/DormitoryMenuSaver'
require 'SwitchToggler'

class ApiController < ApplicationController
  # /api/user_words/user_key/:user_key
  def getUserWordsByUserKey
    user_key = params[:user_key]
    userWords = UserWord.where({ user_key: user_key })
    render json: userWords.as_json
  end
  
  # /api/menu/update
  def updateAllMenu
    dormitoryMenuSaver = DormitoryMenuSaver.new
    dormitoryMenuSaver.getDormitoryMenus('cham').each do |menu|
      puts menu.to_json
    end
  end
  
  # /api/menu_domitory/update?token=[token]
  def updateAllDomitoryMenu
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = DormitoryMenuDb.updateDormitoryMenu();
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  
  # /api/menu_domitory/update/yesterday?token=[token]
  def updateYesterdayToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = SwitchToggler.toggleUseYesterDayDormitoryMenu();
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  
end
