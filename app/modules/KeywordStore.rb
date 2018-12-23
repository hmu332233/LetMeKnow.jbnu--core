class KeywordStore
  def initialize
    @keywords = ["이번주 참빛", "내일 새빛", "평화관 온수시간", "진수당 운영시간", "편의점 시간", "셔틀버스 위치", "셔틀버스 시간", "중도 자리", "ㅎㅅㄱ", "ㄷㄷㄱ", "씨유 시간", "atm 위치"]
  end
  
  def randomizeKeywords(size = 5)
    return @keywords.sample(size)   
  end
end