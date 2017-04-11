class TimeHelper
    
    
    def today
        
        # (Time.now + (9*60*60)).strftime("%A")
        time = (Time.now + (9*60*60))
        
        return time.strftime("%d")
    end
    
    
end