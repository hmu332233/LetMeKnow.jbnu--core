module ManagementHelper
    
    def self.splitData(data)
        
        data_arr = data.split("sp+")
        
        major_data = data_arr[0]
        message_data = data_arr[1]
        
        majors = major_data.split("sp-")
        messages = message_data.split("sp-")
        
        major_data_arr = []
        majors.each do |major|
            major_data = major.split("sp/")
            major_data_arr << major_data
        end
        
        message_data_arr = []
        messages.each do |message|
            message_data = message.split("sp/")
            message_data_arr << message_data
        end
        
        return [major_data_arr,message_data_arr]
    end
    
    def self.setMajor(major_data)
        
        major = Major.new
        major.name = major_data[0]
        major.office = major_data[1]
        major.tel = major_data[2]
        major.fax = major_data[3]
        major.save
        
    end
    
    def self.setMessage(message_data)
        
        message = Message.new
        message.keyword = message_data[0]
        message.content = message_data[1]
        message.save
        
    end
    
    def self.setDB(data)
        
        data_arr = splitData(data)
        majors = data_arr[0]
        messages = data_arr[1]
        
        #major init
        Major.destroy_all
        #message init
        Message.destroy_all
        
        #setMajor
        majors.each do |major|
            setMajor(major)
        end
        #setMessage
        messages.each do |message|
            setMessage(message)
        end
    end
    
    def self.getDB
        
        majors = Major.all
        messages = Message.all
        
        major_string_arr = []
        majors.each do |major|
            attrs = major.attributes
            
            major_string = ""
            major_string += checkNilAndReturn(attrs['name'])
            major_string += "sp/"
            major_string += checkNilAndReturn(attrs['office'])
            major_string += "sp/"
            major_string += checkNilAndReturn(attrs['tel'])
            major_string += "sp/"
            major_string += checkNilAndReturn(attrs['fax']) 
            
            major_string_arr << major_string
        end
        
        message_string_arr = []
        messages.each do |message|
            attrs = message.attributes
      
            message_string = ""
            message_string += checkNilAndReturn(attrs['keyword'])
            message_string += "sp/"
            message_string += checkNilAndReturn(attrs['content'])
            
            message_string_arr << message_string
        end
        
        major_data_string = ""
        major_string_arr.each do |major_string|
            
            major_data_string += major_string
            major_data_string += "sp-"
        end
        
        message_data_string = ""
        message_string_arr.each do |message_string|
            
            message_data_string += message_string
            message_data_string += "sp-"
        end
      
        return major_data_string.chop!.chop!.chop! + "sp+" + message_data_string.chop!.chop!.chop!
    end

    def self.checkNilAndReturn(data)
        
        if data == nil
            return ""
        else
            return data
        end
    end
  

end
