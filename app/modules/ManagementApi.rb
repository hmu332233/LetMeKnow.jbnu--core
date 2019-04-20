require 'util/HttpRequester'

class ManagementApi
  def self.sendUserWord(userKey, messageContent)
    @@TARGET_URL = ENV['management_server']
    @@JSON = { id: userKey, content: messageContent }.to_json
    HttpRequester.requestPostWithJson("#{@@TARGET_URL}/api/v1/user_words", @@JSON)
  end
  
  def self.getJinsuMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/jinsu")
    return json
  end
  
  def self.getMediMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/medi")
    return json
  end
  
  def self.getStudentHallMenu()
    @@TARGET_URL = ENV['management_server']
    json = HttpRequester.requestGetReturnJson("#{@@TARGET_URL}/api/v1/menus/studentHall")
    return json
  end
end



