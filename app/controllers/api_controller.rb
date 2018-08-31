require 'saver/DormitoryMenuSaver'

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
    dormitoryMenuSaver.getCham()
  end
  
  # /api/menu_domitory/update
  def updateAllDomitoryMenu
    dormitoryMenuSaver = DormitoryMenuSaver.new
    dormitoryMenuSaver.saveCham()
  end
  
end
