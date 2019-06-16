require 'parser/JBNUFoodParser'
require 'ManagementApi'

class MenuStore
  def initialize
    @parser = JBNUFoodParser.new
  end

  def getJinsuMenus
    if Sw.useDbMenu?(Sw::JINSU)
      menus = ManagementApi.getJinsuMenu()
    else
      menus = @parser.requestMenu(0)
    end
    return menus
  end
  
  def getJinsuMenusOfDay(day)
    if Sw.useDbMenu?(Sw::JINSU)
      menus = ManagementApi.getJinsuMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_jinsu_mobile(day)
    end
    return menus
  end
  
  def getMediMenus
    if Sw.useDbMenu?(Sw::MEDI)
      menus = ManagementApi.getMediMenu()
    else
      menus = @parser.requestMenu(1)
    end
    return menus
  end
  
  def getMediMenusOfDay(day)
    if Sw.useDbMenu?(Sw::MEDI)
      menus = ManagementApi.getMediMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_medi_mobile(day)
    end
    return menus
  end
  
  def getStudentHallMenus
    if Sw.useDbMenu?(Sw::STUDENT_HALL)
      menus = ManagementApi.getStudentHallMenu()
    else
      menus = @parser.requestMenu(2)
    end
    return menus
  end
  
  def getStudentHallMenusOfDay(day)
    if Sw.useDbMenu?(Sw::STUDENT_HALL)
      menus = ManagementApi.getStudentHallMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_studentHall_mobile(day)
    end
    return menus
  end
  
  def getJungdamMenus
    if Sw.useDbMenu?(Sw::JUNGDAM)
      menus = ManagementApi.getJungdamMenu()
    else
      menus = @parser.requesJungdam()
    end
    return menus
  end
  
  def getJungdamMenusOfDay(day)
    if Sw.useDbMenu?(Sw::JUNGDAM)
      menus = ManagementApi.getJungdamMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_jungdam_mobile(day)
    end
    return menus
  end
  
  def getHuMenus
    if Sw.useDbMenu?(Sw::HU)
      menus = ManagementApi.getHuMenu()
    else
      menus = @parser.requestMenu_hu()
    end
    return menus
  end
  
  def getHuMenusOfDay(day)
    if Sw.useDbMenu?(Sw::HU)
      menus = ManagementApi.getHuMenuOfDay(day-1)
    else
      menus = @parser.requestMenu_hu_mobile(day)
    end
    return menus
  end
end