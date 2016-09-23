require 'Menu'

class JBNU_Food_Parser


    def requestHTML
        
        uri = URI(URI.encode("http://sobi.chonbuk.ac.kr/chonbuk/m040101"))
       
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
    

end