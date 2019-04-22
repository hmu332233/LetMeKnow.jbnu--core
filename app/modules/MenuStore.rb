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
      menus = @parser.requestMenu(0)
    end
    return menus
  end
  
  def getJinsuMenusOfDay(day)
    if self.useDbMenu?
      menus = ManagementApi.getJinsuMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_jinsu_mobile(day)
    end
    return menus
  end
  
  def getMediMenus
    if self.useDbMenu?
      menus = ManagementApi.getMediMenu()
    else
      menus = @parser.requestMenu(1)
    end
    return menus
  end
  
  def getMediMenusOfDay(day)
    if self.useDbMenu?
      menus = ManagementApi.getMediMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_medi_mobile(day)
    end
    return menus
  end
  
  def getStudentHallMenus
    if self.useDbMenu?
      menus = ManagementApi.getStudentHallMenu()
    else
      menus = @parser.requestMenu(2)
    end
    return menus
  end
  
  def getStudentHallMenusOfDay(day)
    if self.useDbMenu?
      menus = ManagementApi.getStudentHallMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_studentHall_mobile(day)
    end
    return menus
  end
end