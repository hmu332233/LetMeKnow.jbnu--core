require 'util/HttpRequester'
require 'LibrarySeat'

class LibraryParser

  def requestEmptySeatData
    doc = HttpRequester.requestNokogiriHtml('http://113.198.32.69/mobile/PW/pw20.php')
    data = parseData(doc)
    return data
  end
  
  def parseData(doc)
    
    librarySeats = []
    
    trs = doc.css("table.default//tr")
    trs.each_with_index do |tr|
      unless tr.attribute('bgcolor').to_s == "#ffffff"
        next
      end
      
      tds = tr.css("td")
      
      if tds.length == 3
        name = tds[0].inner_text.strip
        total = tds[1].inner_text.strip
        spare = tds[2].inner_text.strip
     
        librarySeats << LibrarySeat.new(name, total, spare)
      end
      
    end

    return librarySeats
  end
  
end