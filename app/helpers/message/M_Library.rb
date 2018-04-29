require 'parser/LibraryParser'

module M_Library

  def makeMessage_library_empty_seat
    
    parser = LibraryParser.new
    data = parser.requestEmptySeatData
    
    text = ''
    text += data
    
    return "#{text}"
  end
end