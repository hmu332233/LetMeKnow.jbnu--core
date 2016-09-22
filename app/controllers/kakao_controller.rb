require 'JBNU_Parser'

class KakaoController < ApplicationController
    
    def keyboard
        
        render json: {
            "type": "text"
        }
        
    end
    
    def message
        
        content = params[:content]
        
        if content == "알려줘 학사공지"
            
            parser = JBNU_Parser.new
            
            posts = parser.getPosts(0,"")
            
            titles = ""
            posts.each do |post|
                titles += post.title
            end
            
            result = titles
        end
        
        render json: {
                "message":{
                    "text": "#{result}"
                }
            }

    end
    
    def friend
        render json: ""
    end
    
    def friend2
        render json: ""
    end
    
    def chat_room
        render json: ""
    end
    
end
