class TimeHelper
    
    def now
        time = (Time.now + (9*60*60))
        return time
    end
    
    def today
        
        # (Time.now + (9*60*60)).strftime("%A")
        time = (Time.now + (9*60*60))
        
        return time.strftime("%d")
    end
    

    def dayOfWeek_Today
        
        day = (Time.now + (9*60*60)).strftime("%A").to_s
        return day
    end
    
    def dayOfWeek_Tomorrow
        
        day = (Time.now + (9*60*60) + (24*60*60)).strftime("%A").to_s
        return day
    end
    
    def dayOfWeek_AfterTomprrow
        day = (Time.now + (9*60*60) + (2*(24*60*60))).strftime("%A").to_s
        return day
    end
    
    
end