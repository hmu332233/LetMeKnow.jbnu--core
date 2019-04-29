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
    parser = JBNUFoodParser.new
    menus = parser.requestMenu_hu_mobile(day)
    contents = ""
    i = 0
    contents += dayKor(menus[i].week) + "(" + menus[i].time + ")"+"\n\n"
    contents += menus[i].category + " : " + menus[i].contents[0] + "\n"
    contents += menus[i+1].category + " : " + menus[i+1].contents[0] + "\n"
    contents += menus[i+4].category + " : " + menus[i+4].contents[0] + "\n"
    contents += "\n"
    contents += menus[i+2].category + ":" + "\n\n"
    menus[i+2].contents.each do |con|
      contents += con + "\n"
    end
    contents += "\n\n"
    contents += dayKor(menus[i+3].week) + "(" + menus[i+3].time + ") - " + menus[i+3].category+"\n\n"
    menus[i+3].contents.each do |con|
      contents += con + "\n"
    end
    return contents.to_s.chop!
  end
  
  def makeMessage_hu_all
    parser = JBNUFoodParser.new
    menus = parser.requestMenu_hu
    contents = ""
    i = 0
    while i < menus.size
      contents += menus[i].week + "(" + menus[i].time + ")"+"\n\n"
      contents += menus[i].category + " : " + menus[i].contents[0] + "\n"
      contents += menus[i+1].category + " : " + menus[i+1].contents[0] + "\n"
      contents += menus[i+3].category + " : " + menus[i+3].contents[0] + "\n"
      contents += "\n"
      contents += menus[i+2].category + ":" + "\n\n"
      menus[i+2].contents.each do |con|
          contents += con + "\n"
      end
      contents += "\n\n"
      contents += menus[i+4].week + "(" + menus[i+4].time + ") - " + menus[i+4].category+"\n\n"
      menus[i+4].contents.each do |con|
          contents += con + "\n"
      end
      contents += "\n\n\n"
      i += 5
    end
    return contents.to_s.chop!.chop!.chop!.chop!
  end
end