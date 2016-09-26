class Menu_domitory
    
  attr_reader :week,:breakfast,:lunch,:dinner

  def initialize(week,breakfast, lunch, dinner)
    @week = week
    
    @breakfast = breakfast
    @lunch = lunch
    @dinner = dinner
    
  end
 
end