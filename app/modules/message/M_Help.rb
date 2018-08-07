module M_Help
    
    def makeMessage_help_basic
        
        help_message = 
"알려줘전북대에서 제공하는 기능들입니다.
  
1. 학식 메뉴 기능
2. 각종 운영시간 확인
3. 편의점 시간
4. 중도 좌석 확인
5. 교내 셔틀버스
6. 날씨 확인
7. 학교 공지사항 확인
8. 학과사무실 정보검색
9. 기타
        
자세한 사용법은
아래 링크를 통해 확인해주세요.
http://pf.kakao.com/_LffxoM/1738089
"

        return help_message
    end
    
    def makeMessage_help_notice
        
        notice_message = 
"@ 공지사항 확인

교내공지
교내채용
특강
스터디
알바
판매구매
자취
분실물

ex)
학사공지
교내채용 한번 보여주거라"
        
        return "알려줘전북대의 사용방법 입니다\n\n\n" +  notice_message
    end
    
    def makeMessage_help_menu
        
        menu_message = 
"@ 학식 메뉴 확인

진수당(또는 진수원)
예지원
의대
학생회관
후생관
참빛관
새빛관(또는 기존관,대동관,평화관)

오늘 내일 모레 이번주
  를 입력하시면 다른 날의 메뉴도 알려드립니다.
  
ex)
내일 참빛관
이번주 진수당"

        return "알려줘전북대의 사용방법 입니다\n\n\n" +  menu_message
    end
    
    def makeMessage_help_delivery
        delivery_message = 
"@ 배달음식점 번호 확인

치킨집
중국집(기능 삭제)
"
        return "알려줘전북대의 사용방법 입니다\n\n\n" +  delivery_message
    end
    
    def makeMessage_help_major
        
        major_message = 
"@ 학과사무실 정보 확인


알려줘 과사 [검색어]


[검색어]에 검색하고 싶은 학과의 이름을 입력하세요.
이름의 일부만 입력해도 검색이 가능합니다.

ex)
소프트웨어공학과를 검색하고자 할 때

알려줘 과사 소프트
알려줘 과사 소프트웨어공학
알려줘 과사 소프

등등
모두 가능합니다."
        return "알려줘전북대의 사용방법 입니다\n\n\n" +  major_message
    end
    
    def makeMessage_help_all
    
        all_message = 
"@ 공지사항 확인

교내공지
교내채용
특강
스터디
알바
판매구매
자취
분실물


@ 학식 메뉴 확인

[추가 키워드 :  내일/모레/이번주]
진수당 (또는 진수원)
예지원
의대
학생회관
후생관
참빛관
새빛관 (또는 기존관,대동관,평화관)


@ 배달음식점 번호

치킨집
중국집(기능삭제)


@ 학교 날씨

날씨
내일날씨
주간날씨


@ 학과사무실,치킨몇마리

알려줘 과사 [검색어]
알려줘 치킨몇마리 [사람수]"
    
        return "알려줘전북대의 사용방법 입니다\n\n\n" + "각각의 키워드는 세부기능이 존재하며 하단의 버튼으로 사용법을 확인할 수 있습니다.\n\n\n" +  all_message
    end

    def makeMessage_help_weather
        
         weather_message = 
"@ 날씨 확인


날씨
내일 날씨
주간 날씨


ex)
내일 날씨 알려줘
오늘날씨?

자료제공 : 기상청"

        return "알려줘전북대의 사용방법 입니다\n\n\n" +  weather_message
    end

    def makeMessage_help_etc
    
        etc_message =
"@ 기타 키워드

----------------------------------

알려줘 치킨몇마리 [사람수]

인원수를 입력했을때
피보나치 수열과 제켄도르프정리를 이용하여
최적의 치킨마리수를 알려드립니다.

이게 무슨말이냐구요? 저도 잘 모르겠습니다.

ex) 
알려줘 치킨몇마리 8명
알려줘 치킨몇마리 5

----------------------------------
" 
        return "알려줘전북대의 사용방법 입니다\n\n\n" +  etc_message
    end
     
    
    
end