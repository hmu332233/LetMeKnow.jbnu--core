class Post

  attr_reader :number, :title, :content, :period, :writer

  def initialize(number, title, content,period,writer)
    @number = number
    @title = title
    @content = content
    @period = period
    @writer = writer
  end

end
