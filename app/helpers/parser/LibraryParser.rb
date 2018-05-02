require 'util/HttpRequester'

class LibraryParser

  def requestEmptySeatData
    doc = HttpRequester.requestNokogiriHtml('http://113.198.32.69/mobile/PW/pw20.php')
    data = parseData(doc)
    return data
  end
  
  def parseData(doc)
    
    trs = doc.css("table.default//tr")
    
    trs.each_with_index do |tr|
      tds = tr.css("td")
      
      puts tds.inner_text
      if tds.length == 3
        puts "#{tds[0].inner_text}"
        puts "#{tds[1].inner_text}"
        puts "#{tds[2].inner_text}\n"
      end
      
    end

    return '이건 자리'
  end
  
end