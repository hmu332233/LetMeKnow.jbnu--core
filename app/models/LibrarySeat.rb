class LibrarySeat

  attr_reader :name, :total, :spare

  def initialize(name, total, spare)
    @name = name
    @total = total
    @spare = spare
  end
end
