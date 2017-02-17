class Message < ActiveRecord::Base
    
    def self.findMessageByKeyword(keyword)
        
        message = Message.where("keyword like ?", "%" + keyword + "%").first
        
        unless message == nil
            return message.content
        else
            return nil
        end
        
    end
    
end
