require 'util/HttpRequester'

class LibraryParser

  def requestEmptySeatData
    doc = HttpRequester.requestNokogiriHtml('http://113.198.32.69/mobile/PW/pw20.php')
    data = parseData(doc)
    return data
  end
  
  def parseData(doc)
    return '빈 자리 데이터'
  end
  
end