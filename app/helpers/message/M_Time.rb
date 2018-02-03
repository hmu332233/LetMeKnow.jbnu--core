module M_Time
    
    
    def makeMessage_time_hu
        
        message = 
"
@ 후생관 이용시간입니다.

상시판매
오전 10:00 ~ 오후 7:00

석식(백반)
오후 5:30 ~ 오후 7:00

중간 쉬는 시간 있음.

"

        return message
        
    end
    
    def makeMessage_time_jinsu
        
        message = 
"
@ 진수당 이용시간입니다.

중식
오전 11:30 ~ 오후 2:00

석식
오후 5:30 ~ 오후 7:00

"

        return message
    end
    
    def makeMessage_time_studentHall
    
        message = 
"
@ 학생회관 이용시간입니다.

조식
오전 08:00 ~ 오전 09:00

중식
오전 11:30 ~ 오후 2:00


석식
준비중입니다.

"

        return message    
    
    end
    
    def makeMessage_time_medi
        
        message = 
"
@ 의과대학식당 이용시간입니다.

중식
오전 11:30 ~ 오후 2:00

석식
오후 5:30 ~ 오후 7:00

"
        return message   
    
    end
    
    def makeMessage_time_jungdam
        
        message = 
"
@ 정담원 이용시간입니다.

중식
오전 11:30 ~ 오후 2:00

"
        return message   
        
    end
    
    
    #--------기숙사----------
    def makeMessage_time_dormitory_food
    
        message = 
"
@ 기숙사 식당 이용시간입니다.

월~금
조식 07:30 ~ 09:00
중식 11:45 ~ 13:45
석식 17:30 ~ 19:00

토,일(공휴일)
조식 07:30 ~ 09:00
중식 11:45 ~ 13:45
석식 17:30 ~ 18:30

"
        return message  
        
    end
    
    def makeMessage_time_dormitory_limite
        
        message = 
"
@ 기숙사 통금 이용시간입니다.

오후 11:50 ~ 다음날 오전 04:30

"
        return message  
        
    end
    
    #-----------편의점-------------
    def makeMessage_time_convenience_store
        message = 
"◆ 편의점 시간입니다!

- 기숙사 
항시: ~ 23:15

- 제1학생회관 
학기: 08:00 ~ 22:00 
방학: 08:30 ~ 21:00 
주말: 10:00 ~ 19:00

- 중도 
학기: 08:30 ~ 21:00 
방학: 09:00 ~ 20:00 
주말: 10:00 ~ 19:00

- 학도 
학기: 08:30 ~ 21:00 
방학: 09:00 ~ 20:00 
주말: 10:00 ~ 19:00

- 공대 
학기: 08:30 ~ 19:00 
방학: 09:00 ~ 18:00

- 진수당매점 
학기: 08:30 ~ 20:00

- 건지원매점 
학기: 08:30 ~ 19:00
"
        return message  
    end
    

    
end