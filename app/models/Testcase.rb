class Testcase

  attr_reader :req_message, :status, :res_message

  def initialize(req_message, status, res_message)
    @req_message = req_message
    @status = status
    @res_message = res_message
  end

end
