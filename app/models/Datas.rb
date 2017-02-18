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