require 'Menu'

class JBNU_Food_Parser


    def requestHTML
        
        uri = URI(URI.encode("http://sobi.chonbuk.ac.kr/chonbuk/m040101"))
       
        req = Net::HTTP::Get.new(uri)
    
        res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request(req) }
        doc = Nokogiri::HTML(res.body)
    
        return doc
    end
    
    
    def requestJinsu
        
        doc = requestHTML
        
        tables = doc.css("#sub_right//table")
        
        t = tables[0].css("tr//td")
        
        rt = []
        t.each_with_index do |a,i|
            print i.to_s + " : " +a.inner_text + "\n"
            rt << a.inner_text.to_s.squish
        end
        
        menus = [
            Menu.new("진수원","월","중식","백반",[rt[9],rt[15],rt[20],rt[25]]),
            Menu.new("진수원","화","중식","백반",[rt[10],rt[16],rt[21],rt[26]]),
            Menu.new("진수원","수","중식","백반",[rt[11],rt[17],rt[22],rt[27]]),
            Menu.new("진수원","목","중식","백반",[rt[12],rt[18],rt[23],rt[28]]),
            Menu.new("진수원","금","중식","백반",[rt[13],rt[19],rt[24],rt[29]]),
            Menu.new("진수원","월","석식","백반",[rt[32],rt[37],rt[42],rt[47]]),
            Menu.new("진수원","화","석식","백반",[rt[33],rt[38],rt[43],rt[48]]),
            Menu.new("진수원","수","석식","백반",[rt[34],rt[39],rt[44],rt[49]]),
            Menu.new("진수원","목","석식","백반",[rt[35],rt[40],rt[45],rt[50]]),
            Menu.new("진수원","금","석식","백반",[rt[36],rt[41],rt[46],rt[51]])
            ]
        
        
        return menus
    end
    
    def requestMediMenu
        
        doc = requestHTML
        
        tables = doc.css("#sub_right//table")
        
        t = tables[1].css("tr//td")
        
        rt = []
        t.each_with_index do |a,i|
            print i.to_s + " : " +a.inner_text + "\n"
            rt << a.inner_text.to_s.squish
        end
        
        menus = [
            Menu.new("의대","월","중식","백반",[rt[9],rt[15],rt[20],rt[25]]),
            Menu.new("의대","화","중식","백반",[rt[10],rt[16],rt[21],rt[26]]),
            Menu.new("의대","수","중식","백반",[rt[11],rt[17],rt[22],rt[27]]),
            Menu.new("의대","목","중식","백반",[rt[12],rt[18],rt[23],rt[28]]),
            Menu.new("의대","금","중식","백반",[rt[13],rt[19],rt[24],rt[29]]),
            Menu.new("의대","월","석식","백반",[rt[32],rt[37],rt[42],rt[47]]),
            Menu.new("의대","화","석식","백반",[rt[33],rt[38],rt[43],rt[48]]),
            Menu.new("의대","수","석식","백반",[rt[34],rt[39],rt[44],rt[49]]),
            Menu.new("의대","목","석식","백반",[rt[35],rt[40],rt[45],rt[50]]),
            Menu.new("의대","금","석식","백반",[rt[36],rt[41],rt[46],rt[51]])
            ]
        
        return menus
    end
    
    def requestStudentHallMenu
        
        doc = requestHTML
        
        tables = doc.css("#sub_right//table")
        
        t = tables[2].css("tr//td")
        
        rt = []
        t.each_with_index do |a,i|
            print i.to_s + " : " +a.inner_text + "\n"
            rt << a.inner_text.to_s.squish
        end
        
        menus = [
            Menu.new("의대","월","조식/중식","백반",[rt[9],rt[15],rt[21],rt[27]]),
            Menu.new("의대","화","조식/중식","백반",[rt[10],rt[16],rt[22],rt[28]]),
            Menu.new("의대","수","조식/중식","백반",[rt[11],rt[17],rt[23],rt[29]]),
            Menu.new("의대","목","조식/중식","백반",[rt[12],rt[18],rt[24],rt[30]]),
            Menu.new("의대","금","조식/중식","백반",[rt[13],rt[19],rt[25],rt[31]]),
            Menu.new("의대","월","석식","백반",[rt[35],rt[41],rt[47],rt[53]]),
            Menu.new("의대","화","석식","백반",[rt[36],rt[42],rt[48],rt[54]]),
            Menu.new("의대","수","석식","백반",[rt[37],rt[43],rt[49],rt[55]]),
            Menu.new("의대","목","석식","백반",[rt[38],rt[44],rt[50],rt[56]]),
            Menu.new("의대","금","석식","백반",[rt[39],rt[45],rt[51],rt[57]])
            ]
        
        return menus
    end

end