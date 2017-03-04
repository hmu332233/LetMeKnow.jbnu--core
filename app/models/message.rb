class Message < ActiveRecord::Base
    
    def self.findMessageByKeyword(keyword)
        
        message = Message.where("keyword like ?", "%" + keyword + "%").first
        
        unless message == nil
            return message.content.split("/").sample
        else
            return nil
        end
        
    end
    
    def self.findMessageBySentence( sentence )
        
        message_list = Message.all
        
        message_list.each do |message|
            
            if sentence.include? message.keyword
                return message.content.split("/").sample
            end
        
        end
        
        return nil
    end
    
end
