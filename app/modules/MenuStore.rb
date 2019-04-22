require 'parser/JBNUFoodParser'
require 'ManagementApi'

class MenuStore
  def initialize
    @parser = JBNUFoodParser.new
  end
  
  def useDbMenu?
    begin
      useDbMenu = Sw.find(1).use_db_menu
    rescue
      useDbMenu = Sw.create.use_db_menu
    end
    return useDbMenu
  end
  
  def getJinsuMenus
    if self.useDbMenu?
      menus = ManagementApi.getJinsuMenu()
    else
      menus = JBNUFoodParser.requestMenu(0)
    end
    return menus
  end
  
  def getJinsuMenusOfDay(day)
    if self.useDbMenu?
      menus = ManagementApi.getJinsuMenuOfDay(day)
    else
      menus = JBNUFoodParser.requestMenu_jinsu_mobile(day)
    end
    return menus
  end
end