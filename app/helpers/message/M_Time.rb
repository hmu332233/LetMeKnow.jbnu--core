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
@ 기숙사 식당 이용시간
기존관 식당/참빛관 식당

- 월~금
조식: 07:30 ~ 09:00 / 07:30 ~ 09:00
중식: 11:45 ~ 13:45 / 11:45 ~ 13:45
석식: 17:30 ~ 19:00 / 17:30 ~ 19:00

- 토,일(공휴일)
조식: 08:00 ~ 09:00 / 07:30 ~ 09:00
중식: 12:00 ~ 13:00 / 11:45 ~ 13:45
석식: 17:30 ~ 19:00 / 17:30 ~ 18:30

"
        return message  
        
    end
    
    def makeMessage_time_dormitory_limite
        
        message = 
"
@ 기숙사 통금 시간

- 23:50 ~ 04:30

"
        return message  
        
    end
    
    def makeMessage_time_dormitory_water
        message = 
"
@ 기숙사 온수 시간

기존관(대동, 평화) 
- 06:00 ~ 10:00 
- 18:00 ~ 24:00

참빛, 혜민, 새빛, 한빛관 
- 06:30 ~ 09:30 
- 21:00 ~ 24:00

※ 온수사용량과 기온에 따라 온수 공급시간은 약간 차이가 있을 수 있음.

"
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