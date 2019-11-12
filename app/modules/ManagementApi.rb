require 'util/HttpRequester'
require 'Menu'

class ManagementApi
  def self.sendUserWord(userKey, messageContent)
    @@TARGET_URL = ENV['management_server']
    @@JSON = { id: userKey, content: messageContent }.to_json
    HttpRequester.requestPostWithJson("#{@@TARGET_URL}/api/v1/user_words", @@JSON)
  end
  
  def self.getQuickReplies()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/addon/quick-replies")
    quickReplies = json['data']
    return quickReplies
  end
  
  def self.getJinsuMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/jinsu")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus + dinnerMenus
  end
  
  def self.getJinsuMenuOfDay(day)
    menus = self.getJinsuMenu()
    return [menus[day], menus[day+5]]
  end
  
  def self.getMediMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/medi")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus + dinnerMenus
  end
  
  def self.getMediMenuOfDay(day)
    menus = self.getMediMenu()
    return [menus[day], menus[day+5]]
  end
  
  def self.getStudentHallMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/studentHall")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus + dinnerMenus
  end
  
  def self.getStudentHallMenuOfDay(day)
    menus = self.getStudentHallMenu()
    return [menus[day], menus[day+5]]
  end
  
  def self.getJungdamMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/jungdam")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus
  end
  
  def self.getJungdamMenuOfDay(day)
    menus = self.getJungdamMenu()
    return [menus[day]]
  end
  
  def self.getHuMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/hu")
    breakfastMenus = json['data']['breakfast'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return breakfastMenus + lunchMenus + dinnerMenus
  end
  
  def self.getHuMenuOfDay(day)
    menus = self.getHuMenu()
    breakfastIndex = day
    lunchIndex = 5 + (day * 4)
    dinnerIndex = 25 + day
    return [menus[breakfastIndex], *menus[lunchIndex..lunchIndex+3], menus[dinnerIndex]]
  end
end



