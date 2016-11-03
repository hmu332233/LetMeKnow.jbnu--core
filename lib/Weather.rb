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
  end

end
