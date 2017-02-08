class Bus

  attr_reader :number, :arrive_time, :remain_busstop_num, :lately_busstop

  def initialize(number, arrive_time, remain_busstop_num,lately_busstop)
    @number = number
    @arrive_time = arrive_time
    @remain_busstop_num = remain_busstop_num
    @lately_busstop = lately_busstop
  end

end
