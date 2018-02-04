require 'uri'
require 'net/http'

class Tester
    
    attr_reader :base_url

    def initialize(base_url)
        @base_url = base_url
    end
    
    def getTestResult(message = 'test')

        puts @base_url

        
    end
    
end



