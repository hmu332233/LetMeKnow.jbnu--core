require 'Menu'
require 'Menu_domitory'

class JBNU_Food_Parser

    def requestHTML
        
        uri = URI(URI.encode("http://sobi.chonbuk.ac.kr/chonbuk/m040101"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
    end
    
    def requestHTML_domitory
        
        uri = URI(URI.encode("http://likehome.chonbuk.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_1_k"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
        
    end
    
    def requestHTML_domitory2
        
        uri = URI(URI.encode("http://likehome.chonbuk.ac.kr/board/bbs/board.php?dk_table=cbnu2_7_k"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
        
    end
    
    def requestMenu(place_id)
        
        doc = requestHTML
        
        tables = doc.css("#sub_right//table")
        
        t = tables[place_id].css("tr//td")
        
        rt = []
        t.each_with_index do |a,i|
            print i.to_s + " : " +a.inner_text + "\n"
            rt << a.inner_text.to_s.squish
        end
        
        if place_id == 0
            place = "진수원(진수당)"
        elsif place_id == 1
            place = "의대"
        elsif place_id == 2
            place == "학생회관"
        end
        
        menus = [
            Menu.new(place,"월","중식","백반",[rt[9],rt[15],rt[20],rt[25]]),
            Menu.new(place,"화","중식","백반",[rt[10],rt[16],rt[21],rt[26]]),
            Menu.new(place,"수","중식","백반",[rt[11],rt[17],rt[22],rt[27]]),
            Menu.new(place,"목","중식","백반",[rt[12],rt[18],rt[23],rt[28]]),
            Menu.new(place,"금","중식","백반",[rt[13],rt[19],rt[24],rt[29]]),
            Menu.new(place,"월","석식","백반",[rt[32],rt[37],rt[42],rt[47]]),
            Menu.new(place,"화","석식","백반",[rt[33],rt[38],rt[43],rt[48]]),
            Menu.new(place,"수","석식","백반",[rt[34],rt[39],rt[44],rt[49]]),
            Menu.new(place,"목","석식","백반",[rt[35],rt[40],rt[45],rt[50]]),
            Menu.new(place,"금","석식","백반",[rt[36],rt[41],rt[46],rt[51]])
            ]
        
        
        return menus
    end
    
    def requestStudentHall
        
        doc = requestHTML
        
        tables = doc.css("#sub_right//table")
        
        place_id = 2
        
        t = tables[place_id].css("tr//td")
        
        rt = []
        t.each_with_index do |a,i|
            print i.to_s + " : " +a.inner_text + "\n"
            rt << a.inner_text.to_s.squish
        end
        
        
        
        if place_id == 0
            place = "진수원(진수당)"
        elsif place_id == 1
            place = "의대"
        elsif place_id == 2
            place == "학생회관"
        end
        
        menus = [
            Menu.new(place,"월","중식","백반",[rt[9],rt[15],rt[21],rt[27]]),
            Menu.new(place,"화","중식","백반",[rt[10],rt[16],rt[22],rt[28]]),
            Menu.new(place,"수","중식","백반",[rt[11],rt[17],rt[23],rt[29]]),
            Menu.new(place,"목","중식","백반",[rt[12],rt[18],rt[24],rt[30]]),
            Menu.new(place,"금","중식","백반",[rt[13],rt[19],rt[25],rt[31]]),
            Menu.new(place,"월","석식","백반",[rt[35],rt[41],rt[47],rt[53]]),
            Menu.new(place,"화","석식","백반",[rt[36],rt[42],rt[48],rt[54]]),
            Menu.new(place,"수","석식","백반",[rt[37],rt[43],rt[49],rt[55]]),
            Menu.new(place,"목","석식","백반",[rt[38],rt[44],rt[50],rt[56]]),
            Menu.new(place,"금","석식","백반",[rt[39],rt[45],rt[51],rt[57]])
            ]
        
        
        return menus
        
    end
    
    def requestMenu_hu
        
        doc = requestHTML
        
        tables = doc.css("#sub_right//table")
        
        menu_data = tables[4].css("tr//td")
        
        menu = []
        menu_data.each_with_index do |td,i|
            print i.to_s + " : " + td.inner_text.strip + "\n"
            menu << td.inner_text.strip
        end
        
        
        place = "후생관"
        
        menus = [
            Menu.new(place,"월","중식","특식",[menu[9]]),
            Menu.new(place,"월","중식","찌개",[menu[16]]),
            Menu.new(place,"월","중식","추억의 도시락",[menu[22],menu[27],menu[32]]),
            Menu.new(place,"월","석식","백반",[menu[35],menu[40],menu[45]]),
            Menu.new(place,"화","중식","특식",[menu[10]]),
            Menu.new(place,"화","중식","찌개",[menu[17]]),
            Menu.new(place,"화","중식","추억의 도시락",[menu[23],menu[28],menu[32]]),
            Menu.new(place,"화","석식","백반",[menu[36],menu[41],menu[46]]),
            Menu.new(place,"수","중식","특식",[menu[11]]),
            Menu.new(place,"수","중식","찌개",[menu[18]]),
            Menu.new(place,"수","중식","추억의 도시락",[menu[24],menu[29],menu[32]]),
            Menu.new(place,"수","석식","백반",[menu[37],menu[42],menu[47]]),
            Menu.new(place,"목","중식","특식",[menu[12]]),
            Menu.new(place,"목","중식","찌개",[menu[19]]),
            Menu.new(place,"목","중식","추억의 도시락",[menu[25],menu[30],menu[32]]),
            Menu.new(place,"목","석식","백반",[menu[38],menu[43],menu[48]]),
            Menu.new(place,"금","중식","특식",[menu[13]]),
            Menu.new(place,"금","중식","찌개",[menu[20]]),
            Menu.new(place,"금","중식","추억의 도시락",[menu[26],menu[31],menu[32]]),
            Menu.new(place,"금","석식","백반",[menu[39],menu[44],menu[49]])
            ]
        
       return menus
       
    end
    
    def requestMenu_domitory
        
        doc = requestHTML_domitory
         
        tables = doc.css("#box_list2//a")
        
        
        menu_datas = []
        
        tables.each_with_index do |t,i|
            
            # if i < 3 
            #     print i.to_s + t.inner_text.strip + "\n"
            # elsif i >= 3
            #     print i.to_s + t.inner_text.strip.split("//")[0] + "\n"
            #     print i.to_s + t.inner_text.strip.split("//")[1] + "\n"
            # end
            
            menu_datas << t.inner_text.strip.split("//")
            
        end
        
        menus = []
        
        index = 0
        while index < menu_datas.size
            
            menu = Menu_domitory.new("",menu_datas[index],menu_datas[index+1],menu_datas[index+2])
            menus << menu
            
            index += 3

        end

        print menus
        
        return menus
        
    end
    
    def requestMenu_domitory2
        
        doc = requestHTML_domitory2
         
        tables = doc.css("#box_list2//a")
        
        
        menu_datas = []
        
        tables.each_with_index do |t,i|
            
            # if i < 3 
            #     print i.to_s + t.inner_text.strip + "\n"
            # elsif i >= 3
            #     print i.to_s + t.inner_text.strip.split("//")[0] + "\n"
            #     print i.to_s + t.inner_text.strip.split("//")[1] + "\n"
            # end
            
            menu_datas << t.inner_text.strip.split("//")
            
        end
        
        menus = []
        
        index = 0
        while index < menu_datas.size
            
            menu = Menu_domitory.new("",menu_datas[index],menu_datas[index+1],menu_datas[index+2])
            menus << menu
            
            index += 3

        end

        print menus
        
        return menus
        
    end

end