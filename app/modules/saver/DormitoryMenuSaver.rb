require 'parser/JBNUDormitoryParser'
require 'util/TimeHelper'
require 'Menu_domitory'

class DormitoryMenuSaver
  def saveSpecial
    timeHelpler = TimeHelper.new
    parser = JBNUDormitoryParser.new
    menus = parser.requestMenu_special

    date = timeHelpler.now.to_formatted_s(:year_month_day)
    
    dormitoryMenuDb = DormitoryMenuDb.find_or_create_by(date: date, key_name: 'special')
    dormitoryMenuDb.menus_string = menus.to_json.to_s
    dormitoryMenuDb.save
  end
  
  def saveBasic
    timeHelpler = TimeHelper.new
    parser = JBNUDormitoryParser.new
    menus = parser.requestMenu_Basic

    date = timeHelpler.now.to_formatted_s(:year_month_day)
    
    dormitoryMenuDb = DormitoryMenuDb.find_or_create_by(date: date, key_name: 'basic')
    dormitoryMenuDb.menus_string = menus.to_json.to_s
    dormitoryMenuDb.save
  end
  
  def saveCham
    timeHelpler = TimeHelper.new
    parser = JBNUDormitoryParser.new
    menus = parser.requestMenu_Cham

    date = timeHelpler.now.to_formatted_s(:year_month_day)
    
    dormitoryMenuDb = DormitoryMenuDb.find_or_create_by(date: date, key_name: 'cham')
    dormitoryMenuDb.menus_string = menus.to_json.to_s
    dormitoryMenuDb.save
  end
  
  def getDormitoryMenus(key_name)
    timeHelpler = TimeHelper.new
    date = timeHelpler.now.to_formatted_s(:year_month_day)

    chamJson = JSON.parse(DormitoryMenuDb.find_by(date: date, key_name: key_name).menus_string)
    
    chamData = []
    chamJson.each do |menu|
      chamData << Menu_domitory.new(menu['week'], menu['breakfast'], menu['lunch'], menu['dinner'])
    end
    
    return chamData
  end
  
end