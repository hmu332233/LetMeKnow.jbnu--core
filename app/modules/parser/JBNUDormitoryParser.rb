require 'Menu_domitory'

class JBNUDormitoryParser
    
    def requestHTML_Cham
        
        uri = URI(URI.encode("http://likehome.chonbuk.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_1_k"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
        
    end
    
    def requestHTML_Basic
        
        uri = URI(URI.encode("http://likehome.chonbuk.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_k"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
    end
    
    def requestHTML_special
        
        uri = URI(URI.encode("http://likehome.jbnu.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_2_k"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
    end
    
    def parseData(doc)
        
        menus = []
        
        tables_new = doc.css(".tbline1//tr")
        tables_new.each_with_index do |tr,i|
            
            # puts ""
            # puts i.to_s
            
            tds = tr.css(".tbline2")
            
            dayOfWeek = tds[0].inner_text
            date = tds[1].inner_text.strip
            
            # puts "요일 : #{dayOfWeek}"
            # puts "날짜 : #{date}"
            
            menu_data = []
            as = tds[2].css("a").each do |a|
                menu_data << a.inner_text.strip.split("//")
            end
            
            # puts "아침 : #{menu_data[0]}"
            # puts "점심 : #{menu_data[1]}"
            # puts "저녁 : #{menu_data[2]}"
            
            menu = Menu_domitory.new(dayOfWeek,menu_data[0],menu_data[1],menu_data[2])
            menus << menu
            
        end
        
        menus.shift
        
        return menus
        
    end
    
    def requestMenu_Cham
    
        doc = requestHTML_Cham
        menus = parseData(doc)
       
        return menus
        
    end
    
    def requestMenu_Basic
        
        doc = requestHTML_Basic
        menus = parseData(doc)
       
        return menus
        
    end
    
    def requestMenu_special
        
        doc = requestHTML_special
        menus = parseData(doc)
       
        return menus
        
    end
    
end