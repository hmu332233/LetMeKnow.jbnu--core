class Post

  attr_reader :number, :title, :link, :period, :writer, :category

  def initialize(number, title, link,period,writer,category)
    @number = number
    @title = title
    @link = link
    @period = period
    @writer = writer
    @category = category
  end

end
