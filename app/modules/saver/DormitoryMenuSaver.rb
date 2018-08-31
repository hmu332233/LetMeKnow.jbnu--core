require 'parser/JBNUDormitoryParser'
require 'Menu_domitory'

class DormitoryMenuSaver
  def saveCham
    parser = JBNUDormitoryParser.new
    menus = parser.requestMenu_Cham
    
    dormitoryMenuDb = DormitoryMenuDb.new
    dormitoryMenuDb.menus_string = menus.to_json.to_s
    dormitoryMenuDb.save
  end
  
  def getCham
    chamJson = JSON.parse(DormitoryMenuDb.last.menus_string)
    
    chamData = []
    chamJson.each do |menu|
      chamData << Menu_domitory.new(menu['week'], menu['breakfast'], menu['lunch'], menu['dinner'])
    end
    
    return chamData
  end
  
end