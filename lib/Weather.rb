class Weather

  attr_reader :hour, :day, :temp, :tmx, :tmn, :wfKor, :pop

  def initialize(hour, day, temp,tmx,tmn,wfKor,pop)
    @hour = hour    #시간
    @day = day      #오늘/내일
    @temp = temp    #온도
    @tmx = tmx      #최고온도
    @tmn = tmn      #최저온도
    @wfKor = wfKor  #날씨상태
    @pop = pop      #강수확률
 
    # 이모티콘
    case wfKor
    when "흐리고 비" , "흐리고비" , "비"
      @wfKor = " (비)"
    when "구름많음" , "구름 많음"
      @wfKor = " (구름)"
    when "구름조금" , "구름 조금"
      @wfKor = " (해)"
    when "흐림"
      @wfKor = " (구름)(구름)"
    end
  end

end
