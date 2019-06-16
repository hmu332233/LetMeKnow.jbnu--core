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
      DormitoryMenuDb.updateDormitoryMenu();
      render json: { success: true }
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
  
  # /api/menu_domitory/update/use_db?token=[token]
  def updateDbToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = SwitchToggler.toggleUseDbMenu();
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  
  # /api/menu_domitory/update/medi/use_db?token=[token]
  def updateDbMediToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = Sw.toggleUseDbMenu(Sw::MEDI)
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  
  # /api/menu_domitory/update/hu/use_db?token=[token]
  def updateDbHuToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = Sw.toggleUseDbMenu(Sw::HU)
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  # /api/menu_domitory/update/jungdam/use_db?token=[token]
  def updateDbJungdamToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = Sw.toggleUseDbMenu(Sw::JUNGDAM)
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  # /api/menu_domitory/update/jinsu/use_db?token=[token]
  def updateDbJinsuToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = Sw.toggleUseDbMenu(Sw::JINSU)
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  # /api/menu_domitory/update/student_hall/use_db?token=[token]
  def updateDbStudentHallToggle
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = Sw.toggleUseDbMenu(Sw::STUDENT_HALL)
      render json: { success: true, result: result }
    else
      render json: { success: false }
    end
  end
  
  # /api/menu_domitory/use_db?token=[token]
  def getUseDb
    token = params[:token]
    if !token.nil? && (token == ENV['saver_token'])
      result = Sw.get()
      render json: {
        success: true,
        result: {
          medi: result.use_db_medi,
          hu: result.use_db_hu,
          jungdam: result.use_db_jungdam,
          jinsu: result.use_db_jinsu,
          student_hall: result.use_db_student_hall
        } 
      }
    else
      render json: { success: false }
    end
  end
  
end
