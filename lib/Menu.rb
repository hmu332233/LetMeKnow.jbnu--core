class Menu
    
  attr_reader :shop_name, :week, :time, :category, :contents

  def initialize(shop_name, week, time, category ,contents)
    @shop_name = shop_name
    @week = week
    @time = time
    @category = category
    @contents = contents
  end
 
end