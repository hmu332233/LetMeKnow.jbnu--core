class JsonMaker
    
    def getUrlBtnJson(text,label,url)
        
        json = {
            "message": {
                "text": text,
                "message_button": {
                  "label": label,
                  "url": url
                }
            }
        }
        
        return json
        
    end
    
end