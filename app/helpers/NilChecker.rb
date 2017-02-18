module NilChecker
    
     def self.checkNilAndReturnString(data)
        
        if data == nil
            return ""
        else
            return data
        end
    end
    
end