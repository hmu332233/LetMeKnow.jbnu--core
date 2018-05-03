require 'parser/LibraryParser'

module M_Library

  def makeMessage_library_empty_seat
    parser = LibraryParser.new
    data = parser.requestEmptySeatData[0..17]
    
    text = "◆ 중도 자리 ◆\n\n"
    data.each do |librarySeat|
      text += "#{librarySeat.name}\n사용/총 좌석: #{librarySeat.total}\n\n"
    end
    return "#{text.strip}"
  end
end