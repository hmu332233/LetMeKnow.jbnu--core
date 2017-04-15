require 'message/M_Dormitory'
require 'message/M_Menu'
require 'message/M_Help'

class MessageFactory
    
    include M_Dormitory
    include M_Menu
    include M_Help
    
end