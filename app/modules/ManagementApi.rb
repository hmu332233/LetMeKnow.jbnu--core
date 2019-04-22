require 'util/HttpRequester'
require 'Menu'

class ManagementApi
  def self.sendUserWord(userKey, messageContent)
    @@TARGET_URL = ENV['management_server']
    @@JSON = { id: userKey, content: messageContent }.to_json
    HttpRequester.requestPostWithJson("#{@@TARGET_URL}/api/v1/user_words", @@JSON)
  end
  
  def self.getJinsuMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/jinsu")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus + dinnerMenus
  end
  
  def self.getMediMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/medi")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus + dinnerMenus
  end
  
  def self.getStudentHallMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/studentHall")
    lunchMenus = json['data']['lunch'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    dinnerMenus = json['data']['dinner'].map { |menu| Menu.new(menu['place'], menu['week'], menu['time'], menu['category'], [menu['menus']]) }
    return lunchMenus + dinnerMenus
  end
end



