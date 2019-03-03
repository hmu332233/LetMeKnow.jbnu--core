require 'Menu_domitory'
require 'net/http'

class JBNUDormitoryParser
    
    def requestHTML_Cham
        
        uri = URI(URI.encode("http://likehome.chonbuk.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_1_k"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
        
    end
    
    def requestHTML_Basic
        
        # uri = URI(URI.encode("http://likehome.chonbuk.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_k"))
        uri = URI(URI.encode("http://likehome.jbnu.ac.kr/home/main/inner.php?sMenu=B7100"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
    end
    
    def requestHTML_special
        
        # uri = URI(URI.encode("http://likehome.jbnu.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_2_k"))
        uri = URI(URI.encode("http://likehome.jbnu.ac.kr/home/main/inner.php?sMenu=B7300"))
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
  
  def parseDateNew(doc)
    
    data = Array.new(7){Array.new(3, "")}
    tableBodyElement = doc.css("#calendar > table > tbody")
    tableRows = tableBodyElement.css("tr")
    tableRows.each_with_index do |tr, i|
      tableData = tr.css("td")
      tableData.each_with_index do |td, j|
        # puts "#{i} #{j}"
        # puts td.inner_text.strip
        data[j][i] = td.inner_text.strip
      end
    end

    menus = [
      Menu_domitory.new("일", data[0][0], data[0][1], data[0][2]),
      Menu_domitory.new("월", data[1][0], data[1][1], data[1][2]),
      Menu_domitory.new("화", data[2][0], data[2][1], data[2][2]),
      Menu_domitory.new("수", data[3][0], data[3][1], data[3][2]),
      Menu_domitory.new("목", data[4][0], data[4][1], data[4][2]),
      Menu_domitory.new("금", data[5][0], data[5][1], data[5][2]),
      Menu_domitory.new("토", data[6][0], data[6][1], data[6][2])
    ]

    return menus
  end
    
    def requestMenu_Cham
    
        doc = requestHTML_Cham
        menus = parseData(doc)
       
        return menus
        
    end
    
    def requestMenu_Basic
        
        doc = requestHTML_Basic
        # menus = parseData(doc)
        menus = parseDateNew(doc)
       
        return menus
        
    end
    
    def requestMenu_special
        
        doc = requestHTML_special
        # menus = parseData(doc)
        menus = parseDateNew(doc)
       
        return menus
        
    end
    
end