require 'Major'

class Datas
    
    def getChick
        
        uri = URI(URI.encode("https://openapi.naver.com/v1/search/local.xml?display=30&start=1&query=치킨 전북대"))

        req = Net::HTTP::Get.new(uri)
        
        req['X-Naver-Client-Id'] = ENV["naver_id"]
        req['X-Naver-Client-Secret'] = ENV["naver_sc"]
        
        
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }

        
        xml_doc = Nokogiri::XML(res.body)
        
        chik_array = []
        
        xml_doc.xpath("//item").each do |item|
            title = item.xpath("title")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            tele = item.xpath("telephone")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            
            chik_array << [title,tele]
        end

        return chik_array
    end
    
    def getChina
        
        uri = URI(URI.encode("https://apis.daum.net/local/v1/search/keyword.xml?apikey=#{ENV["daum_id"]}&location=35.84674878005919,127.12942528419897&radius=5000&query=+"+"중국집"+"+&page=1&sort=0"))

        req = Net::HTTP::Get.new(uri)
 
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }

        xml_doc = Nokogiri::XML(res.body)
        
        print xml_doc
        
        chik_array = []
        
        xml_doc.xpath("//item").each do |item|
            title = item.xpath("title")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            tele = item.xpath("phone")[0].inner_text.gsub(/<\/?[^>]*>/, "")
            
            chik_array << [title,tele]
        end

        return chik_array
        
    end
    
    
    def getMajors
        
        majors = [
            Majors.new("공공인재학부/글로벌인재관 2층/Tel 063-270-4704"),
            Majors.new("지미카터국제학부/글로벌인재관 212호/Tel 063-270-4688"),
            Majors.new("간호학과/간호대학 205호/Tel 063-270-4484, 4485"),
            
            Majors.new("IT응용시스템공학과/공대 1호관 142호/Tel (063)270-4773,4778 /Fax (063)270-4542"),
            Majors.new("IT정보공학과/공대 7호관 224호/Tel (063)270-2410 /Fax (063)270-2394"),
            Majors.new("건축공학과/공대 1호관 132호/Tel (063)270-2276 /Fax (063)270-2285"),
            Majors.new("고분자나노공학과/공대 9호관 719호/Tel (063)270-2335 /Fax (063)270-2341"),
            Majors.new("기계공학과/공대 4호관 212호/Tel (063)270-2316 /Fax (063)270-2315"),
            Majors.new("기계설계공학부 기계설계공학전공/공대 3호관 211호/Tel (063)270-2452 /Fax (063)270-2460"),
            Majors.new("기계설계공학부 나노바이오기계시스템공학전공/공대 3호관 211호/Tel (063)270-2339 /Fax (063)270-2460"),
            Majors.new("기계시스템공학부/공대 4호관 114호/Tel (063)270-2367 /Fax (063)270-2388"),
            Majors.new("도시공학과/공대 9호관 917호/Tel (063)270-4051 /Fax (063)270-4052"),
            Majors.new("바이오메디컬공학부/공대 1호관 332호/Tel (063)270-4063 /Fax (063)270-2247"),
            Majors.new("사회기반공학과/공대 1호관 329호/Tel (063)270-4784 /Fax (063)270-4785"),
            Majors.new("산업정보시스템공학과/공대 6호관 418호/Tel (063)270-2327 /Fax (063)270-2333"),
            Majors.new("소프트웨어공학과/공대 5호관 113호/Tel (063)270-4541 /Fax (063)270-4767"),
            Majors.new("신소재공학부 금속시스템공학전공/공과대학 4호관 210호/Tel 063-270-2286 /Fax 063-270-2305"),
            Majors.new("신소재공학부 전자재료공학전공/공과대학 5호관 304호/Tel 063-270-2378 /Fax 063-270-2386"),
            Majors.new("신소재공학부 정보소재공학전공/공과대학 4호관 210호/Tel 063-270-3969 /Fax 063-270-2305"),
            Majors.new("양자시스템공학과/공대 1호관 156호/Tel 063-270-4997 /Fax 063-270-4998"),
            Majors.new("유기소재파이버공학과/공대2호관 314호/Tel (063)270-2349 /Fax (063)270-2348"),
            Majors.new("융합기술공학과/전주캠퍼스 공과대학 1호관 206호, 프론티어캠퍼스(새만금) 캠퍼스관 413호/Tel 063-270-4225(전주),063-472-2893(새만금) /Fax 063-270-4226(전주), 063-472-2894(새만금)"),
            Majors.new("자원·에너지 공학과/공대2호관 304호/Tel (063)270-2358 /Fax (063)270-2366"),
            Majors.new("전기공학과/공대 7호관 224호/Tel (063)270-2389 /Fax (063)270-2394"),
            Majors.new("전자공학부/공대 7호관 224호/Tel (063)270-2475, 2409, 2462 /Fax (063)270-2394"),
            Majors.new("컴퓨터공학부/공대 7호관 224호/Tel (063)270-3431, 4233 /Fax (063)270-2394"),
            Majors.new("토목공학과/공대1호관 263호/Tel (063)270-2420 /Fax (063)270-2421"),
            Majors.new("항공우주공학과/공대 9호관 620호/Tel (063)270-2468 /Fax (063)270-2472"),
            Majors.new("화학공학부/공대 6호관 118호/Tel (063)270-2431 /Fax (063)270-2306"),
            Majors.new("환경공학과/공대 6호관 320호/Tel (063)270-2441 /Fax (063)270-2449"),
            
            Majors.new("농생물학과/농생대 3호관 105호/Tel (063)270-2524 /Fax (063)270-2531"),
            Majors.new("농업경제학과/농생대 4호관 418호실/Tel (063)270-2532 /Fax (063)270-2635"),
            Majors.new("동물생명공학과/농생대 본관 308호실/Tel (063)270-4748 /Fax (063)270-2614"),
            Majors.new("동물자원과학과(동물소재공학과)/농생대 3호관 108호실/Tel (063)270-2604 /Fax (063)270-2612"),
            Majors.new("목재응용과학과/농생대 4호관 209호/Tel (063)270-2621 /Fax (063)270-2631"),
            Majors.new("산림환경과학과/농생대 본관 330호/Tel (063)270-2583 /Fax (063)270-2592"),
            Majors.new("생명자원유통경제학과/농업생명과학대학 1호관 2층/Tel 063-270-4165 /Fax 063-270-4166"),
            Majors.new("생명자원융합학과/농업생명과학대학 본관 208호/Tel 063-270-4956 /Fax 063-270-4957"),
            Majors.new("생물산업기계공학과/농생대 4호관 305호/Tel (063)270-2613 /Fax (063)270-2620"),
            Majors.new("생물환경화학과/농생대 2호관 107호/Tel (063)270-2541 /Fax (063)270-2550"),
            Majors.new("식품공학과/농생대 4호관 119호/Tel (063)270-2565 /Fax (063)270-2572"),
            Majors.new("원예학과/농생대 2호관 311호/Tel (063)270-2574 /Fax (063)270-2581"),
            Majors.new("작물생명과학과/농생대 2호관 310호/Tel (063)270-2506 /Fax (063)270-2640"),
            Majors.new("조경학과/농생대 3호관 313호실/Tel (063)270-2594 /Fax (063)270-2600"),
            Majors.new("지역건설공학과/농생대 본관 122호/Tel (063)270-2515 /Fax (063)270-2517"),
            
            Majors.new("과학교육학부/물리교육전공 사범대 과학관 115호 생물교육전공 사범대 과학관 310-2호 지구과학교육전공 사범대 과학관 323호화학교육전공 사범대 과학관 113호/Tel 063-270-2810 /Fax 063-270-2811"),
            Majors.new("교육학과/진수당 교육연구동 2층 204호/Tel 063-270-2739 /Fax 063-270-2743"),
            Majors.new("국어교육과/사범대 본관 4층 423호/Tel (063)270-2711 /Fax (063)270-2718"),
            Majors.new("독어교육과/사범대 본관 3층 302호/Tel (063)270-2720 /Fax (063)270-2721"),
            Majors.new("수학교육과/사범대 본관 4층 403호/Tel (063)270-2791 /Fax (063)270-2792"),
            Majors.new("역사교육과/진수당 교육연구동 4층 411호/Tel 063-270-2765 /Fax 063-270-2764"),
            Majors.new("영어교육과/사범대 본관 3층 323호/Tel (063)270-2728 /Fax (063)270-2737"),
            Majors.new("윤리교육과/진수당 교육연구동 3층 311호/Tel (063)270-2753 /Fax (063)270-2761"),
            Majors.new("일반사회교육과/진수당 교육연구동 4층 411호/Tel (063)270-2765 /Fax (063)270-2764"),
            Majors.new("지리교육과/진수당 교육연구동 5층 520호/Tel (063)270-2731 /Fax (063)270-2730"),
            Majors.new("체육교육과/사범대 예체능관 2층 220호/Tel (063)270-2849 /Fax (063)270-2850"),
            
            Majors.new("사회복지학과/사회대 311호/Tel (063)270-2962 /Fax (063)270-2968"),
            Majors.new("사회학과/사회대 313호/Tel (063)270-2916 /Fax (063)270-2921"),
            Majors.new("신문방송학과/사회대 511호/Tel (063)270-2952 /Fax (063)270-2967"),
            Majors.new("심리학과/사회대 4층/Tel (063)270-2925 /Fax (063)270-2933"),
            Majors.new("정치외교학과/사회대 212호/Tel (063)270-2934 /Fax (063)270-2935"),
            Majors.new("행정학과/사회대 312호/Tel (063)270-2943 /Fax (063)270-2944"),
            
            Majors.new("경영학부/상대 2호관 215호 (경영학전공), 상대 2호관 213호 (회계학전공)/Tel (063)270-2986 (경영학전공), 063)270-3023 (회계학전공) /Fax (063)270-2985 (경영학전공), (063)270-3042 (회계학전공)"),
            Majors.new("경제학부/상대 제2호관 3층 315호/Tel 063-270-3001 /Fax 063-270-3040"),
            Majors.new("무역학과/상대 제2호관 105호실/Tel (063)270-3013 /Fax (063)270-3041"),
            
            Majors.new("식품영양학과/생활대 2층 205호/Tel (063)270-3855 /Fax (063)270-3854"),
            Majors.new("아동학과/생활대 4층 405호/Tel (063)270-3835 /Fax (063)270-3839"),
            Majors.new("의류학과/생활대 3층 305호/Tel (063)270-3845 /Fax (063)270-3799"),
            Majors.new("주거환경학과/생활대 5층 505호/Tel (063)270-3632 /Fax (063)270-3649"),
            
            Majors.new("수의예과/10-1 건물 106호, 익산 특성화캠퍼스 행정관 101호 행정실/Tel 063-850-0911 /Fax 063-850-0912"),
            Majors.new("수의학과/익산 특성화캠퍼스 행정관 행정실 101호/Tel 063-270-3425(전주)063-850-0911(익산) /Fax 063-850-0912"),
            
            Majors.new("무용학과/예술대 구관 2층 2230호실/Tel (063)270-3746 /Fax (063)270-3748"),
            Majors.new("미술학과/예술대 신관 1층 1270호실/Tel (063)270-3726 /Fax (063)270-2827"),
            Majors.new("산업디자인학과/예술대 신관 2층 2010호실/Tel (063)270-3755 /Fax (063)270-3587"),
            Majors.new("음악과/예술대 신관 3층 3220호실/Tel (063)270-3736 /Fax (063)270-3737"),
            Majors.new("한국음악학과/예술대 신관 4층 4230호실/Tel (063)270-3716 /Fax (063)270-3709"),
            
            Majors.new("고고문화인류학과/인문대 2호관 2층 230호/Tel (063)270-3283 /Fax (063)270-3282"),
            Majors.new("국어국문학과/인문대 1호관 3층 323호실/Tel (063)270-3166 /Fax (063)270-3169"),
            Majors.new("독어독문학과/인문대 2호관 2층 224호실/Tel (063)270-3181 /Fax (063)270-3295"),
            Majors.new("문헌정보학과/인문대 2호관 1층 109호실/Tel (063)270-3253 /Fax (063)270-3260"),
            Majors.new("사학과/인문대 2호관 2층 227호/Tel (063)270-3224 /Fax (063)270-3225"),
            Majors.new("스페인∙중남미학과/인문대 1호관 3층 326호실/Tel (063)270-3275 /Fax (063)270-3274"),
            Majors.new("영어영문학과/인문대 1호관 3층 324호실/Tel (063)270-3199 /Fax (063)270-3201"),
            Majors.new("일어일문학과/인문대 2호관 1층 115호실/Tel (063)270-3261 /Fax (063)270-3269"),
            Majors.new("중어중문학과/인문대 2호관 4층 409호실/Tel 063-270-3215 /Fax (063)270-3223"),
            Majors.new("철학과/인문대 1호관 3층 325호/Tel (063)270-3239 /Fax (063)270-3240"),
            Majors.new("프랑스학과/인문대 2호관 2층 225호실/Tel (063)270-3190 /Fax (063)270-3296"),
            
            Majors.new("과학학과/자연대 3호관 2층 205호실/Tel (063)270-3433 /Fax (063)270-3434"),
            Majors.new("물리학과/자연대 5호관 207호/Tel (063)270-3321 /Fax (063)270-3320"),
            Majors.new("반도체과학기술학과/자연대 3호관 3층 303호실/Tel (063)270-3971 /Fax (063)270-3972"),
            Majors.new("분자생물학과/자연대 4호관 2305호/Tel 063-270-3338 /Fax 063-270-3345"),
            Majors.new("생명과학과/자연대 2호관 122호/Tel 063-270-3351 /Fax 063-270-3362"),
            Majors.new("수학과/자연대 본관 409호/Tel (063)270-3364 /Fax (063)270-3363"),
            Majors.new("스포츠과학과/자연대 3호관 102호실/Tel (063)270-2819 /Fax (063)270-4234"),
            Majors.new("지구환경과학과/자연대 4호관 2122호/Tel (063)270-3393 /Fax (063)270-3399"),
            Majors.new("통계학과/자연대 본관 209호/Tel (063)270-3380 /Fax (063)270-3405"),
            Majors.new("화학과/자연대 1호관 210호/Tel (063)270-3406 /Fax (063)270-3408"),
            
            Majors.new("바이오식품공학과/2공학관 7308호/Tel (063)850-0747 /Fax (063)850-0747"),
            Majors.new("생명공학부/2공학관 7108호/Tel (063)850-0835 /Fax (063)850-0834"),
            Majors.new("생태조경디자인학과/1공학관 204호/Tel (063)850-0735 /Fax (063)850-0735"),
            Majors.new("한약자원학과/4공학관/Tel (063)850-0741 /Fax (063)850-0741")
            ]
        
        
        # majors =  Major.new("IT응용시스템공학과/공대 1호관 142호/Tel (063)270-4773,4778 /Fax (063)270-4542")
        
        return majors
    end
    
    
    def getChikNum(people_num)
        
        result = "1 : 1
        2 : 1
        3 : 2
        4 : 3
        5 : 3
        6 : 4
        7 : 4
        8 : 5
        9 : 6
        10 : 6
        11 : 7
        12 : 8
        13 : 8
        14 : 9
        15 : 9
        16 : 10
        17 : 11
        18 : 11
        19 : 12
        20 : 12
        21 : 13
        22 : 14
        23 : 14
        24 : 15
        25 : 16
        26 : 16
        27 : 17
        28 : 17
        29 : 18
        30 : 19
        31 : 19
        32 : 20
        33 : 21
        34 : 21
        35 : 22
        36 : 22
        37 : 23
        38 : 24
        39 : 24
        40 : 25
        41 : 25
        42 : 26
        43 : 27
        44 : 27
        45 : 28
        46 : 29
        47 : 29
        48 : 30
        49 : 30
        50 : 31
        51 : 32
        52 : 32
        53 : 33
        54 : 33
        55 : 34
        56 : 35
        57 : 35
        58 : 36
        59 : 37
        60 : 37
        61 : 38
        62 : 38
        63 : 39
        64 : 40
        65 : 40
        66 : 41
        67 : 42
        68 : 42
        69 : 43
        70 : 43
        71 : 44
        72 : 45
        73 : 45
        74 : 46
        75 : 46
        76 : 47
        77 : 48
        78 : 48
        79 : 49
        80 : 50
        81 : 50
        82 : 51
        83 : 51
        84 : 52
        85 : 53
        86 : 53
        87 : 54
        88 : 55
        89 : 55
        90 : 56
        91 : 56
        92 : 57
        93 : 58
        94 : 58
        95 : 59
        96 : 59
        97 : 60
        98 : 61
        99 : 61
        100 : 62".split("\n")[people_num].strip

        return result
        
    end
    
    
end