require 'util/HttpRequester'

class ManagementApi
  def self.sendUserWord(userKey, messageContent)
    @@TARGET_URL = ENV['management_server']
    @@JSON = { id: userKey, content: messageContent }.to_json
    HttpRequester.requestPostWithJson(@@TARGET_URL, @@JSON)
  end
end



