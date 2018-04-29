require 'util/HttpRequester'

class LibraryParser

  def requestEmptySeatData
    doc = HttpRequester.requestNokogiriHtml('http://113.198.32.69/mobile/PW/pw20.php')
  end
  
  def parseData
    
  end
  
end