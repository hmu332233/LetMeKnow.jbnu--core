class Major

    attr_reader :name, :office, :tel, :fax

    def initialize(data)
        
        datas = data.split("/")
        
        @name = datas[0].to_s
        @office = datas[1].to_s
        @tel = datas[2].to_s
        @fax = datas[3].to_s
    end


end