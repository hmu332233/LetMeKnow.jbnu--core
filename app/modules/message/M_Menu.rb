require 'parser/JBNUFoodParser'
require 'MenuStore'

module M_Menu
    #학식 모바일
    def makeMessage_jinsu_day(day)
      if day > 5 or day == 0
        return "주말에는 운영하지 않습니다"
      end
      menuStore = MenuStore.new
      menus = menuStore.getJinsuMenusOfDay(day)
      return makeMenusMessage(menus)
    end
    
    def makeMessage_medi_day(day)
      if day > 5 or day == 0
        return "주말에는 운영하지 않습니다"
      end
      menuStore = MenuStore.new
      menus = menuStore.getMediMenusOfDay(day)
      return makeMenusMessage(menus)
    end
    
    def makeMessage_studentHall_day(day)
      if day > 5 or day == 0
          return "주말에는 운영하지 않습니다"
      end
      menuStore = MenuStore.new
      menus = menuStore.getStudentHallMenusOfDay(day)
      return makeMenusMessage(menus)
    end
    
    def makeMessage_yeji_day(day)
      if day > 5 or day == 0
          return "주말에는 운영하지 않습니다"
      end
      parser = JBNUFoodParser.new
      menus = parser.requestMenu_yeji_mobile(day)
     return makeMenusMessage(menus)
    end
    
    def makeMessage_jungdam_day(day)
      if day > 5 or day == 0
          return "주말에는 운영하지 않습니다"
      end
      menuStore = MenuStore.new
      menus = menuStore.getJungdamMenusOfDay(day)
      return makeMenusMessage(menus)
    end
    
    #이번주 메뉴
    def makeMessage_jungdam_all
      menuStore = MenuStore.new
      menus = menuStore.getJungdamMenus()
      return makeMenusMessage(menus)
    end
   
    def makeMessage_yeji_all        
      parser = JBNUFoodParser.new
      menus = parser.requestYeji
      return makeMenusMessage(menus)
    end
    
    def makeMessage_jinsu_all
      menuStore = MenuStore.new
      menus = menuStore.getJinsuMenus()
      return makeMenusMessage(menus)
    end
    
    def makeMessage_medi_all
      menuStore = MenuStore.new
      menus = menuStore.getMediMenus()
      return makeMenusMessage(menus)
    end
  
    def makeMessage_studentHall_all
      menuStore = MenuStore.new
      menus = menuStore.getStudentHallMenus()
      return makeMenusMessage(menus)
    end
  
    def makeMenuMessage(menu)
      week = menu.week.is_a?(Integer) ? dayKor(menu.week) : menu.week
      text = week + "(" + menu.time + ") - " + menu.category+"\n\n"
      menu.contents.each do |m|
          text += m + "\n"
      end
      return text
    end
  
    def makeMenusMessage(menus)
      messages = menus.map { |menu| makeMenuMessage(menu) }
      return messages.join("\n\n");
    end

    def dayKor(day)
    
        case day
        when 1
            result = "월"
        when 2
            result = "화"
        when 3
            result = "수"
        when 4
            result = "목"
        when 5
            result = "금"
        when 6
            result = "토"
        end
        
        return result
    end
  
  
  # 후생관
  def makeMessage_hu_day(day)
    if day > 5 or day == 0
      return "주말에는 운영하지 않습니다"
    end
    menuStore = MenuStore.new
    menus = menuStore.getHuMenusOfDay(day)
    return makeHuMenuMessage(menus)
  end
  
  def makeMessage_hu_all
    menuStore = MenuStore.new
    menus = menuStore.getHuMenus()
    return makeHuMenusMessage(menus)
  end
  
  def makeHuMenuMessage(menus)
    week = menus[0].week.is_a?(Integer) ? dayKor(menus[0].week) : menus[0].week
    breakfastTime = menus[0].time
    lunchTime = menus[1].time
    dinnerTime = menus[5].time

    text = week + "(" + breakfastTime + ") - " + menus[0].category+"\n\n"
    menus[0].contents.each do |content|
      text += content + "\n"
    end
    text += "\n\n"
    text += week + "(" + lunchTime + ")"+"\n\n"
    text += menus[1].category + " : " + menus[1].contents[0] + "\n"
    text += menus[2].category + " : " + menus[2].contents[0] + "\n"
    text += menus[4].category + " : " + menus[4].contents[0] + "\n"
    text += "\n"
    text += menus[3].category + ":" + "\n\n"
    menus[3].contents.each do |content|
      text += content + "\n"
    end
    text += "\n\n"
    text += week + "(" + dinnerTime + ") - " + menus[5].category+"\n\n"
    menus[5].contents.each do |content|
      text += content + "\n"
    end
    return text
  end
  
  def makeHuMenusMessage(menus)
    huMenus = [
      [menus[0], *menus[5..8], menus[25]],
      [menus[1], *menus[9..12], menus[26]],
      [menus[2], *menus[13..16], menus[27]],
      [menus[3], *menus[17..20], menus[28]],
      [menus[4], *menus[21..24], menus[29]]
    ]
    
    messages = huMenus.map { |menus| makeHuMenuMessage(menus) }
    return messages.join("\n\n");
  end
end